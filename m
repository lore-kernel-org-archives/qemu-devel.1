Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FEEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE252082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaWpFOaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE252082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3DC-0001zr-C1
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo35O-0005P7-QK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:56:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo35M-0003cE-Fu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592996215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T37ak+iDPz5gKf6w3ZG3Hd68LNFp/kjpM3L+xYpV2Ik=;
 b=JaWpFOajPTObadw9OtHkAODu8kSIZ/AnLZhNBBXUjmgNMKaHCOW4kJXQ3GGhl3PWm+EoKR
 OrbWSXLih4Zf3KaGUah74+Z+s/QmouPkMorGDI8ED0G82UlUdE2NNg7Wmh9Pa/bLv3rV7+
 AzzDZ8NRmWEKT9U1Qyhh3yuH01CQSoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-J9LzBJLPOMyhAVSEFjtkgw-1; Wed, 24 Jun 2020 06:56:53 -0400
X-MC-Unique: J9LzBJLPOMyhAVSEFjtkgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10A32804001;
 Wed, 24 Jun 2020 10:56:52 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B567FD03;
 Wed, 24 Jun 2020 10:56:47 +0000 (UTC)
Date: Wed, 24 Jun 2020 11:56:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
Message-ID: <20200624105644.GG774096@redhat.com>
References: <20200603161409.54682-1-liq3ea@163.com>
 <CAKXe6SJ-HNK-ZKYcGCGsiUmYi_MVGrVmSvric2OjK5m2q=TBjg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJ-HNK-ZKYcGCGsiUmYi_MVGrVmSvric2OjK5m2q=TBjg@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: zxq_yx_007@163.com, marcandre lureau <marcandre.lureau@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 02:12:58PM +0800, Li Qiang wrote:
> Ping..
> Anyone queued this?

Thanks, I've queud this now.

> 
> Thanks,
> Li Qiang
> 
> Li Qiang <liq3ea@163.com> 于2020年6月4日周四 上午12:31写道：
> 
> > After build qemu with '-fsanitize=address' extra-cflags,
> > 'make check' show following leak:
> >
> > =================================================================
> > ==44580==ERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 2500 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f1b5a8b8d28 in __interceptor_calloc
> > (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
> >     #1 0x7f1b5a514b10 in g_malloc0
> > (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
> >     #2 0xd79ea4e4c0ad31c3  (<unknown module>)
> >
> > SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).
> >
> > Call 'g_rand_free' in the end of function to avoid this.
> >
> > Fixes: 4d3a329af59("tests/util-sockets: add abstract unix socket cases")
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/test-util-sockets.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> > index 2ca1e99f17..ca6671f9bf 100644
> > --- a/tests/test-util-sockets.c
> > +++ b/tests/test-util-sockets.c
> > @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
> >      g_thread_join(serv);
> >
> >      g_free(abstract_sock_name);
> > +    g_rand_free(r);
> >  }
> >  #endif
> >
> > --
> > 2.17.1
> >
> >
> >

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


