Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74309C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 17:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B05C20838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 17:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B05C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Hzo-0002f9-8O
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 13:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6Hz8-00028c-7E
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6Hz5-0007Yy-4v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:25:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i6Hz4-0007V0-Ju
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AA27302C060
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 17:25:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BBE31001925;
 Fri,  6 Sep 2019 17:25:16 +0000 (UTC)
Message-ID: <676393243dbf38470b514a8dc11024380ff836d8.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 06 Sep 2019 20:25:15 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 06 Sep 2019 17:25:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] IOTEST 162
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I just had a very fun rabbit hole dive, and I want to share it with you.

I notice for some time that iotest 162 fails with that:

-qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket: Invalid argument
+qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket:
Connection timed out


I didn't bother to report it yet as it started failing more or less when qemu 4.2 merge window opened,
so I thought that maybe something got broken, or maybe something broken in my environment 
(ahem, AF_UNIX path is too long, ahem)

I just didn't had enough time to pay attention to this. Until today.

So I asked Kevin Wolf today, just by the way why I see for some time that
iotest 162 fails. for me.


He told me that it works for him.
So I look at the test and I see that it just does

qemu-img info 'json:{"driver": "nbd", "host": 42}'

Supposedly it should fail because 42 is not quoted, and it 
doesn't look like a valid host name.

I try with disto's qemu-img (2.11) and I still see that I get the 'Connection timed out'

Then I ask him to try on his system with '42' quoted and it still passes.

All right - this means that this 42 is parsed. He also mentions that he uses fedora 29 and I still
use fedora 28. So I start a VM with fedora 30, and yep, there it does work correctly.

All right, that 42 must be parsed as a host name. Yep. 'ping 42' on my machine tries to ping 0.0.0.42,
and in VM exits immediately with 'Invalid argument'
All right, lets ping 0.0.0.42. Maybe something in hostname parsing changed, maybe something parses this on DNS level?
Nope, ping 0.0.0.42 works on my machine, fails with invalid argument in VM...

All right lets strace it

connect(5, {sa_family=AF_INET, sin_port=htons(1025), sin_addr=inet_addr("0.0.0.42")}, 16) = -1 EINVAL (Invalid argument)

Same thing passes on my machine....

Hmm... this is something in the kernel. Maybe something in iptables/etc. I don't yet know that
area that well to be honest.

So I googled a bit and look what I found:

https://lwn.net/Articles/791086/

And yes, while my machine runs fedora 28, it as usual runs vanilla git master
kernel, which I compile from time to time. Currently I am on 5.3.0-rc4+.

So I must say that nothing less but kernel 5.3.0, breaks iotest 162.

I''l prepare a patch soon to fix this.

Best regards,
	Maxim Levitsky





