Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCDD2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCDD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fVY-0004ZC-IZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7fSv-0002Mm-PA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7fSu-00054i-JS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7fSo-00051o-Ix; Tue, 10 Sep 2019 08:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C4E3765AD;
 Tue, 10 Sep 2019 12:41:41 +0000 (UTC)
Received: from localhost (ovpn-117-90.ams2.redhat.com [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B2845C224;
 Tue, 10 Sep 2019 12:41:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 14:41:29 +0200
Message-Id: <20190910124136.10565-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 10 Sep 2019 12:41:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/7] block/curl: Fix hang and potential crash
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As reported in https://bugzilla.redhat.com/show_bug.cgi?id=3D1740193, our
curl block driver can spontaneously hang.  This becomes visible e.g.
when reading compressed qcow2 images:

$ qemu-img convert -p -O raw -n \
  https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img \
  null-co://

(Hangs at 74.21 %, usually.)

A more direct way is:

$ qemu-img bench -f raw http://download.qemu.org/qemu-4.1.0.tar.xz \
    -d 1 -S 524288 -c 2

(Which simply performs two requests, and the second one hangs.  You can
use any HTTP resource (probably FTP, too) you=E2=80=99d like that is at l=
east
1 MB in size.)

It turns out that this is because cURL 7.59.0 has added a protective
feature against some misuse we had in our code: curl_multi_add_handle()
must not be called from within a cURL callback, but in some cases we
did.  As of 7.59.0, this fails, our new request is not registered and
the I/O request stalls.  This is fixed by patch 6.

Patch 7 makes us check for curl_multi_add_handle()=E2=80=99s return code,
because if we had done that before, debugging would have been much
simpler.


On the way to fixing it, I had a look over the whole cURL code and found
a suspicious QLIST_FOREACH_SAFE() loop that actually does not seem very
safe at all.  I think this may lead to crashes, although I have never
seen any myself.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1744602#c=
5
shows one in exactly the function in question, so I think it actually is
a problem.

This is fixed by patch 5, patches 1, 2, and 4 prepare for it.

(Patch 3 is kind of a misc patch that should ensure that we always end
up calling curl_multi_check_completion() whenever a request might have
been completed.)


v2:
- Patch 2: Remove the socket from the list only add the end of the
           function (yielding a nicer 5+/5- diff stat)
- Patch 3: Added
- Patch 4: Rebased on patch 3, and s/socket/ready_socket/ in one place
- Patch 5: Rebased on the changed patch 4


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[----] [--] 'curl: Keep pointer to the CURLState in CURLSocket'
002/7:[0007] [FC] 'curl: Keep *socket until the end of curl_sock_cb()'
003/7:[down] 'curl: Check completion in curl_multi_do()'
004/7:[0019] [FC] 'curl: Pass CURLSocket to curl_multi_{do,read}()'
005/7:[0002] [FC] 'curl: Report only ready sockets'
006/7:[----] [--] 'curl: Handle success in multi_check_completion'
007/7:[----] [--] 'curl: Check curl_multi_add_handle()'s return code'


Max Reitz (7):
  curl: Keep pointer to the CURLState in CURLSocket
  curl: Keep *socket until the end of curl_sock_cb()
  curl: Check completion in curl_multi_do()
  curl: Pass CURLSocket to curl_multi_do()
  curl: Report only ready sockets
  curl: Handle success in multi_check_completion
  curl: Check curl_multi_add_handle()'s return code

 block/curl.c | 133 +++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 74 deletions(-)

--=20
2.21.0


