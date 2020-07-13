Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79C1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42876206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUt/4Hke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42876206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwHG-0004QW-A1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1juwFO-0002T5-Ih
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:03:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1juwFM-0005OB-Ew
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594638223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sP0gJ3Vit25VjSbYfUQXfjecxcXFUrgtVIgGRi2J3SU=;
 b=IUt/4Hke6tHS4J0ODNzN0XvFSwk0PpB6Pk3HJ5kFXr1t9E8KQx1D0U+m0dnalbCXW/ezi3
 g/GxnT8p3SAO9NaG1+nV6+czZRasogEmk6Vq98tQFnVuJ7oHCIm3ttJVXcHrPaUAtGnx9V
 ot5gQOeM3CSkKtCCQ/ZMOqrXdwS21Fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-f-VNB5AfN3yKgdc5y-Lg9A-1; Mon, 13 Jul 2020 07:03:41 -0400
X-MC-Unique: f-VNB5AfN3yKgdc5y-Lg9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A7719200C1;
 Mon, 13 Jul 2020 11:03:40 +0000 (UTC)
Received: from work-vm (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF9A15C66E;
 Mon, 13 Jul 2020 11:03:35 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:03:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: migration: broken snapshot saves appear on s390 when small
 fields in migration stream removed
Message-ID: <20200713110333.GE3122@work-vm>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
MIME-Version: 1.0
In-Reply-To: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Claudio Fontana (cfontana@suse.de) wrote:
> Hello all,
> 
> during unrelated work for splitting QTest from the TCG instruction counting module,
> 
> I encountered what seems to be a migration stream issue, which is apparent only on s390, and only shows in block test 267.
> 
> ./check -qcow2 267
> 
> when it comes to snapshot save and load using backing file.
> 
> Here is a minimal reproducer patch that causes the issue on s390 only.
> 
> --------------------------------------------cut-------------------------------------------
> diff --git a/cpus.c b/cpus.c
> index 41d1c5099f..443b88697a 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
>  
>  static bool icount_state_needed(void *opaque)
>  {
> -    return use_icount;
> +    return 0;
>  }

That's weird; I mean that's just turning a subsection on and off;
so you'd hope if this is a test that generates it's own snapshot and
then uses it then it should be consistent.

>  static bool warp_timer_state_needed(void *opaque)
> --------------------------------------------cut-------------------------------------------
> 
> config.status configure line:
> exec '/home/cfontana/qemu-build/../qemu/configure' '--enable-tcg' '--disable-kvm' '--disable-hax' '--target-list=s390x-softmmu' '--enable-debug'
> 
> $ make check-block
> 
> TEST    iotest-qcow2: 267 [fail]
> QEMU          -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../s390x-softmmu/qemu-system-s390x" -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../qemu-img" 
> QEMU_IO       -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio threads -f qcow2
> QEMU_NBD      -- "/home/cfontana/qemu-build/tests/qemu-iotests/../../qemu-nbd" 
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/s390x s390zp13 5.3.18-21-default
> TEST_DIR      -- /home/cfontana/qemu-build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.bLJcJVtzk5
> SOCKET_SCM_HELPER -- /home/cfontana/qemu-build/tests/qemu-iotests/socket_scm_helper
> 
> --- /home/cfontana/qemu/tests/qemu-iotests/267.out	2020-07-12 05:10:07.948262675 -0400
> +++ /home/cfontana/qemu-build/tests/qemu-iotests/267.out.bad	2020-07-12 05:27:03.358362781 -0400
> @@ -137,6 +137,9 @@
>  ID        TAG                 VM SIZE                DATE       VM CLOCK
>  --        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>  (qemu) loadvm snap0
> +Unexpected storage key flag data: 0
> +error while loading state for instance 0x0 of device 's390-skeys'
> +Error: Error -22 while loading VM state
>  (qemu) quit
>  
>  
> -----------
> 
> 
> Not run: 172 186 192 259 287
> Failures: 267
> Failed 1 of 115 iotests
> make: *** [/home/cfontana/qemu/tests/Makefile.include:880: check-tests/check-block.sh] Error 1
> 
> -----------
> 
> Note: only the === -blockdev with a backing file === part of test 267 fails. -blockdev with NBD is ok, like all the rest.
> 
> 
> Interesting facts about s390 in particular: its save/load code includes the transfer of "storage keys",
> which include a buffer of 32768 bytes of keydata in the stream.
> 
> The code (hw/s390x/s390-skeys.c),
> is modeled similarly to RAM transfer (like in migration/ram.c), with an EOS (end of stream) marker.
> 
> Countrary to RAM transfer code though, after qemu_put_be64(f, EOS), the s390 code does not qemu_fflush(f).
> 
> ----------
> Observation: the migration/qemu-file.c shows an IO_BUF_SIZE of 32768.
> 
> --
> 
> The following workarounds hide the problem (make the test pass):
> 
> 1) always including the icount field in the (unrelated) timers field that are sent before in the migration stream (ie not applying the reproducer patch).
> 
> 2) increasing the IO_BUF_SIZE also hides the problem:
> 
> ----------------------cut--------------------------
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index be21518c57..f81d1272eb 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -30,7 +30,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  
> -#define IO_BUF_SIZE 32768
> +#define IO_BUF_SIZE 65536
>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>  
>  struct QEMUFile {
> ----------------------cut--------------------------
> 
> 3) adding a qemu_fflush in hw/s390x/s390-skeys.c after EOS also "fixes" the problem:
> 
> ----------------------cut--------------------------
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 1e036cc602..47c9a015af 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -252,6 +252,8 @@ static const TypeInfo qemu_s390_skeys_info = {
>      .class_size    = sizeof(S390SKeysClass),
>  };
>  
> +extern void qemu_fflush(QEMUFile *f);
> +
>  static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>  {
>      S390SKeysState *ss = S390_SKEYS(opaque);
> @@ -302,6 +304,7 @@ static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>      g_free(buf);
>  end_stream:
>      qemu_put_be64(f, eos);
> +    qemu_fflush(f);
>  }
>  
>  static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
> ----------------------cut--------------------------
> 
> Do any of you with better understanding of migration/, block and s390 have a suggestion on what could be the issue here,
> and what could be the next step in the investigation?
> 
> Is the fact that migration/ram.c always does fflush after writing the EOS have any relevance here? why does it do it,
> and should s390 code also follow the same pattern?

I didn't think it was required.
And qemu_put_buffer loops if needed and calls qemu_fflush internally.
It's possible here that the storage key code is just the canary - the
first thing that detects that the stream is invalid after it all goes
wrong.

Dave


> Thanks,
> 
> Claudio
> 
> 
> -- 
> Claudio Fontana
> Engineering Manager Virtualization, SUSE Labs Core
> 
> SUSE Software Solutions Italy Srl
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


