Received: from eggs.gnu.org ([2001:4830:134:3::10]:35474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1czJEL-0003MK-UE
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 04:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1czJEK-0001pi-Gq
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 04:38:53 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:32921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1czJEK-0001pZ-Bc
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 04:38:52 -0400
Received: by mail-oi0-x229.google.com with SMTP id b187so107981720oif.0
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 01:38:51 -0700 (PDT)
MIME-Version: 1.0
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 15 Apr 2017 14:08:50 +0530
Message-ID: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

Some of you are already aware but for the benefit of the open list,
this mail is regarding the task mentioned
Here -> http://wiki.qemu-project.org/ToDo/Block/DmgChunkSizeIndependence

I had a chat with Fam regarding this and he suggested a solution where
we fix the output buffer size to a max of say "64K" and keep inflating
until we reach the end of the input stream. We extract the required
data when we enter the desired range and discard the rest. Fam however
termed this as only a  "quick fix".

The ideal fix would obviously be if we can somehow predict the exact
location inside the compressed stream relative to the desired offset
in the output decompressed stream, such as a specific sector in a
chunk. Unfortunately this is not possible without doing a first pass
over the decompressed stream as answered on the zlib FAQ page
Here -> http://zlib.net/zlib_faq.html#faq28

AFAICT after reading the zran.c example in zlib, the above mentioned
ideal fix would ultimately lead us to decompress the whole chunk in
steps at least once to maintain an access point lookup table. This
solution is better if we get several random access requests over
different read requests, otherwise it ends up being equal to the fix
suggested by Fam plus some extra effort needed in building and
maintaining access points.

I have not explored the bzip2 compressed chunks yet but have naively
assumed that we will face the same situation there?

I would like the community's opinion on this and add their suggestions
if possible to give me some new thinking points.

Thanks
Ashijeet
