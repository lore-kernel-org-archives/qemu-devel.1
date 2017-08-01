Received: from eggs.gnu.org ([2001:4830:134:3::10]:46093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcSey-0003Z6-V1
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcSex-0002WI-Vn
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:36:12 -0400
References: <20170711170821.24669-1-ppandit@redhat.com>
	<29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
	<20170721154712.GM18014@stefanha-x1.localdomain>
	<b3ba0182-8700-76fc-5d20-97c054137ef9@redhat.com>
	<e8a30256-9b83-1c58-d8e6-9ec5192604b6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a90fa30-00b3-b389-5b78-54b55046648c@redhat.com>
Date: Tue, 1 Aug 2017 10:35:58 +0200
MIME-Version: 1.0
In-Reply-To: <e8a30256-9b83-1c58-d8e6-9ec5192604b6@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: check BlockDriverState
 object before dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Kieron Shorrock <kshorrock@paloaltonetworks.com>, Prasad J Pandit <pjp@fedoraproject.org>, Markus Armbruster <armbru@redhat.com>

On 01/08/2017 02:14, John Snow wrote:
> I may need some nudging towards understanding what the right solution
> here is, though. Should the blk_aio_flush assume that there always is a
> root BDS? should it not assume that?

I think blk_aio_flush is not special.  If there is no root BDS, either
you return -ENOMEDIUM, or you crash.  But all functions should be doing
the same.

The former makes sense, but right now blk_prwv for one are crashing if
there is no root BDS so the minimum patch would fix the caller rather
than blk_aio_flush.

Paolo

> It's difficult for me to understand right now if the bug is in the
> expectation for the blk_ functions and the caller should be amended, or
> if you need changes to the way the blk_ functions are trying to
> increment a counter that doesn't exist.
> 
> I can handle the former fairly easily; if it's the latter, I'm afraid
> it's stuck in the middle of some of your changes and I'd need a stronger
> hint.
