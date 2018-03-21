Received: from eggs.gnu.org ([2001:4830:134:3::10]:43806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eydb1-0003wP-F2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eydax-00085E-Fl
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:16:03 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1809fec1-cdf6-0da4-14e8-04b01d4fc48b@redhat.com>
References: <20180320135515.16823-1-berto@igalia.com>
	<665e0ccd-4440-4e0e-30f9-e38537795325@redhat.com>
	<w51po3xixqz.fsf@maestria.local.igalia.com>
	<1809fec1-cdf6-0da4-14e8-04b01d4fc48b@redhat.com>
Date: Wed, 21 Mar 2018 14:15:57 +0100
Message-ID: <w51muz1in76.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] qcow2: Reset free_cluster_index
 when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 21 Mar 2018 02:08:23 PM CET, Eric Blake wrote:
>>   - This scenario is harder to reach: in order to fill a 1-cluster
>>   refcount table the size of the image needs to be larger than
>>   (cluster_size=C2=B3 / refcount_bits) bytes, that's 16TB with the defau=
lt
>>   parameters. So although it can be reproduced easily if you reduce
>>   the cluster size I think it's very infrequent under normal
>>   conditions.
>
> Yes, 16TB for default size, but only 2M for the best-case (512-byte
> cluster, 64-bit refcount), so still easy to write a test for.

The test case is indeed very easy:

   qemu-img create -f qcow2 -o cluster_size=3D512 hd.qcow2 16M
   qemu-io -c 'write 0 8222208' hd.qcow2
   qemu-io -c 'write 8222208 512' hd.qcow2

What I haven't done is debug the problem yet.

As I said I don't think this happens often in a real-world scenario, so
I wanted to fix the simple (and more common) problem first.

Berto
