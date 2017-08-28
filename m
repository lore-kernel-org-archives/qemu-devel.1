Received: from eggs.gnu.org ([2001:4830:134:3::10]:38110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmMcF-0004xp-CH
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmMcC-0000Jg-42
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:10:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dmMcB-0000GB-Ty
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:10:16 -0400
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6f537126-f1a6-2159-d8f7-35d34b803dfa@redhat.com>
Date: Mon, 28 Aug 2017 18:10:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170823083901.852-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 23.08.2017 10:39, Juan Quintela wrote:
> We were using -1 instead of the real size because the functions check
> what is bigger, size in bytes or the size of the iov.  Recent gcc's
> barf at this.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/test-iov.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

While you're at it, could you maybe also adjust the comments in
include/qemu/iov.h ? It currently says:

 * It is okay to use very large value for `bytes' since we're
 * limited by the size of the iovec anyway, provided that the
 * buffer pointed to by buf has enough space.  One possible
 * such "large" value is -1 (sinice size_t is unsigned),
 * so specifying `-1' as `bytes' means 'up to the end of iovec'.

... and apparently -1 is not working anymore as expected. Maybe SIZE_MAX
from stdint.h is a better choice?

 Thomas
