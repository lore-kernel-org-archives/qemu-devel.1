Received: from eggs.gnu.org ([2001:4830:134:3::10]:53214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHTos-0004a4-CZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHToo-0003Ie-FX
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:03:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cHToo-0003Gm-8Q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:03:22 -0500
References: <20161214163035.3297-1-maxime.coquelin@redhat.com>
	<20161215073808.GB26169@stefanha-x1.localdomain>
	<20161215092656.2e1244c0.cornelia.huck@de.ibm.com>
	<20161215103145.GG2762@stefanha-x1.localdomain>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <185aa91e-b50d-c068-0b1c-6b5c1371393d@redhat.com>
Date: Thu, 15 Dec 2016 12:03:15 +0100
MIME-Version: 1.0
In-Reply-To: <20161215103145.GG2762@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 12/15/2016 11:31 AM, Stefan Hajnoczi wrote:
> On Thu, Dec 15, 2016 at 09:26:56AM +0100, Cornelia Huck wrote:
>> On Thu, 15 Dec 2016 07:38:09 +0000
>> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>>> On Wed, Dec 14, 2016 at 05:30:35PM +0100, Maxime Coquelin wrote:
>>>> This patch fixes a cross-version migration regression introduced
>>>> by commit d1b4259f ("virtio-bus: Plug devices after features are
>>>> negotiated").
>>>>
>>>> The problem is encountered when host's vhost backend does not support
>>>> VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
>>>> machine with virtio-pci modern capabilities enabled to a v2.8 machine.
>>>>
>>>> In this case, modern capabilities get exposed to the guest by the source,
>>>> whereas the target will detect version 1 is not supported so will only
>>>> expose legacy capabilities.
>>>>
>>>> The problem is fixed by introducing a new "x-ignore-backend-features"
>>>> property, which is set in v2.7 and prior compatibility modes. Doing this,
>>>> v2.7 machine keeps its broken behaviour (enabling modern while version
>>>> is not supported), and newer machines will behave correctly.
>>>>
>>>> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>> ---
>>>>
>>>> V3 fixes commit message with the new property name.
>>>> V2 changes the naming as proposed by Michael T.and Cornelia, and
>>>> fixes commit message.
>>>>
>>>>  hw/virtio/virtio-pci.c | 5 ++++-
>>>>  hw/virtio/virtio-pci.h | 1 +
>>>>  include/hw/compat.h    | 4 ++++
>>>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> Thanks, applied to my staging tree:
>>> https://github.com/stefanha/qemu/commits/staging
>>>
>>> Stefan
>>
>> Hm, missing my R-b I gave for v2... feel free to add
>>
>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>
>> if you still want to change it.
>
> Sorry, the R-b didn't make it into v2.8.0-rc4.
>
> The patch management scripts I use apply all R-b for a single email
> thread.  They do not look at previous revisions (it would be hard to
> tell which R-b still stand and which do not).  The usual solution is for
> the patch author to include previous R-b in new revisions as long as
> code changes aren't substantial.
Right that's my fault, sorry Cornelia.

Maxime
>
> Stefan
>
