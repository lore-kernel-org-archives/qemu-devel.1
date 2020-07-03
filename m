Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9217C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83113207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbZXKArp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83113207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGUB-0007it-SB
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrGTc-0007E3-FK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:51:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34823
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrGTa-00050W-J5
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593762673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OomwJDRjOdy3cYIwpP3K219A6XnRgH7kEcVcPhoKq7M=;
 b=bbZXKArpjhMAdLTzE9nQ5ei0r4Ayjmkiw5Td57JAPeZ/Uql4HNj6YBt01CQ7cox0drq6vl
 fK5z+uEnd/G2CGD2CgplJ+6XBCHFNCR1xW3EvCrPbNMvcF6FUN/ewmfPuDJFnOmVe5VDD6
 wtY4TD3+buJJy7Q11/yIahe1b9OYh+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-fIfF2gOLMDOXJbQdsW61Qw-1; Fri, 03 Jul 2020 03:51:08 -0400
X-MC-Unique: fIfF2gOLMDOXJbQdsW61Qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CF27106C00F;
 Fri,  3 Jul 2020 07:51:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AD4C76116;
 Fri,  3 Jul 2020 07:51:00 +0000 (UTC)
Date: Fri, 3 Jul 2020 09:50:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/2] hw/block/nvme: handle transient dma errors
Message-ID: <20200703075059.GA5285@linux.fritz.box>
References: <20200629202053.1223342-1-its@irrelevant.dk>
 <159346486377.15477.6186679362319226240@d1fd068a5071>
 <20200629213408.qlehce2mtgqodqd6@apples.localdomain>
 <30b8117f-25bd-e50b-98cb-db2e0a2690d0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <30b8117f-25bd-e50b-98cb-db2e0a2690d0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Cc: qemu-block@nongnu.org, k.jensen@samsung.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, kbusch@kernel.org, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.07.2020 um 14:58 hat Philippe Mathieu-Daudé geschrieben:
> On 6/29/20 11:34 PM, Klaus Jensen wrote:
> > On Jun 29 14:07, no-reply@patchew.org wrote:
> >> Patchew URL: https://patchew.org/QEMU/20200629202053.1223342-1-its@irrelevant.dk/
> 
> >> --- /tmp/qemu-test/src/tests/qemu-iotests/040.out       2020-06-29 20:12:10.000000000 +0000
> >> +++ /tmp/qemu-test/build/tests/qemu-iotests/040.out.bad 2020-06-29 20:58:48.288790818 +0000
> >> @@ -1,3 +1,5 @@
> >> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest
> >> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest
> 
> Kevin, Max, can iotests/040 be affected by this change?

The diffstat of this series looks like it doesn't touch anything outside
of the nvme emuation, which isn't used by this test, so at least I'd say
it's not the fault of the patch series.

I think test cases use SIGKILL primarily in timeout handlers, so maybe
the test host was overloaded and didn't shutdown QEMU in time so it was
killed. There is no actually failing test case:

 ...........................................................
 ----------------------------------------------------------------------
 Ran 59 tests

You would have 'F' or 'E' for fail/error instead of '.' otherwise.

Kevin

> > 
> > 
> > Hmm, I can't seem to reproduce this locally and the test succeeded on
> > the next series[1] that is based on this.
> > 
> > Is this a flaky test? Or a bad test runner? I'm of course worried when
> > a qcow2 test fails and I touch something else than the nvme device ;)
> > 
> > 
> >   [1]: https://patchew.org/QEMU/20200629203155.1236860-1-its@irrelevant.dk/
> > 
> 


