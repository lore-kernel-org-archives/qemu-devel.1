Received: from eggs.gnu.org ([2001:4830:134:3::10]:53433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dUSPW-0003cU-In
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dUSPT-0004kq-IL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:43:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59082
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dUSPT-0004fU-Ab
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:43:07 -0400
References: <20170707213052.13087-1-ehabkost@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a660181f-4f97-339d-d3ed-4e543787d00b@ilande.co.uk>
Date: Mon, 10 Jul 2017 07:42:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170707213052.13087-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] qom: Fix ambiguous path detection when
 ambiguous=NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>

On 07/07/17 22:30, Eduardo Habkost wrote:

> object_resolve_path*() ambiguous path detection breaks when
> ambiguous==NULL and the object tree have 3 objects of the same type and
> only 2 of them are under the same parent.  e.g.:
> 
>  /container/obj1 (TYPE_FOO)
>  /container/obj2 (TYPE_FOO)
>  /obj2 (TYPE_FOO)
> 
> With the above tree, object_resolve_path_type("", TYPE_FOO, NULL) will
> incorrectly return /obj2, because the search inside "/container" will
> return NULL, and the match at "/obj2" won't be detected as ambiguous.
> 
> Fix that by always calling object_resolve_partial_path() with a non-NULL
> ambiguous parameter.
> 
> Test case included.
> 
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Eduardo Habkost (2):
>   tests: Test case for object_resolve_path*()
>   qom: Fix ambiguous path detection when ambiguous=NULL
> 
>  qom/object.c               | 17 ++++++++---------
>  tests/check-qom-proplist.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 9 deletions(-)

I've done a quick test here and I get a pass on "make check" with these
patches applied so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Later on I'll also rework my fw_cfg patchset and send out a v8 which
should hopefully be the last iteration.


ATB,

Mark.
