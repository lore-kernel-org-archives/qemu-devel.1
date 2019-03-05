Received: from eggs.gnu.org ([209.51.188.92]:49837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1h190o-000070-Mk
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1h190n-00032m-U9
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:17:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1h190n-0002uk-MM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:17:33 -0500
Message-ID: <3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 05 Mar 2019 13:09:49 +0100
In-Reply-To: <20181205195704.17605-1-ehabkost@redhat.com>
References: <20181205195704.17605-1-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Michael
	S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Amit Shah <amit@kernel.org>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Cole Robinson <crobinso@redhat.com>, Daniel Berrange <berrange@redhat.com>

Sorry to resurrect such an old thread, but I have been wondering...

On Wed, 2018-12-05 at 17:57 -0200, Eduardo Habkost wrote:
[...]
> Changes v1 -> v2:
> * Removed *-0.9 devices.  Nobody will want to use them, if
>   transitional devices work with legacy drivers
>   (Gerd Hoffmann, Michael S. Tsirkin)
> * Drop virtio version from name: rename -1.0-transitional to
>   -transitional (Michael S. Tsirkin)
> * Renamed -1.0 to -non-transitional
> * Don't add any extra variants to modern-only device types
>   (they don't need it)

... if doing this was a good idea after all?

While I understand that something like virtio-gpu, which supports
the 1.0 specification exclusively, only really needs to have a
single device associated with it from the functionality point of
view, looking at it from a user's perspective it seems to me like
providing an explicit non-transitional variant would be appropriate
for consistency reasons, so that your guest could look like

  -device virtio-blk-pci-non-transitional \
  -device virtio-net-pci-non-transitional \
  -device virtio-gpu-pci-non-transitional \

and you wouldn't have to question why you can use the
non-transitional variant for pretty much everything, except for the
few cases where you can't - for no apparent reason...

It would also signal quite clearly which devices support both
transitional and non-transitional variants and which ones don't,
without having to infer that the complete lack of (non-)transitional
variants means that only the non-transitional variant is available -
except you have to use the suffix-less device name to use it.

tl;dr providing the non-transitional variant for virtio 1.0-only
      devices would make using this much more user-friendly.

-- 
Andrea Bolognani / Red Hat / Virtualization
