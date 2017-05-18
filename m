Received: from eggs.gnu.org ([2001:4830:134:3::10]:50114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dBKS1-0000rZ-83
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dBKS0-000071-4z
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:22:41 -0400
References: <20170518100925.28682-1-vsementsov@virtuozzo.com>
	<20170518102523.GD4646@noname.redhat.com>
	<4f9deae2-c489-9681-83d3-e878adb33946@virtuozzo.com>
	<20170518121026.GF4646@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <aa80a3e6-07c4-22cb-1dc4-24102b67ecfe@openvz.org>
Date: Thu, 18 May 2017 15:22:24 +0300
MIME-Version: 1.0
In-Reply-To: <20170518121026.GF4646@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qcow2: add allocated-size to image
 specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com

On 05/18/2017 03:10 PM, Kevin Wolf wrote:
> Am 18.05.2017 um 13:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 18.05.2017 13:25, Kevin Wolf wrote:
>>> Am 18.05.2017 um 12:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Shows, how much data qcow2 allocates in underlying file. This should=

>>>> be helpful on non-sparse file systems, when qemu-img info "disk size=
"
>>>> doesn't provide this information.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>> Hi all.
>>>>
>>>> Here is an allocated-size feature for qemu-img info.
>>> I'm not a fan of loading all L2 tables (can take some time) for
>>> 'qemu-img info' (which should be very quick). Why isn't the qemu-img
>>> check output good enough?
>>>
>>> Kevin
>>>
>>> $ ./qemu-img check /tmp/test.qcow2
>>> No errors were found on the image.
>>> 16164/491520 =3D 3.29% allocated, 11.98% fragmented, 0.00% compressed=
 clusters
>>> Image end offset: 1060044800
>>> $ ./qemu-img check --output=3Djson /tmp/test.qcow2
>>> {
>>>     "image-end-offset": 1060044800,
>>>     "total-clusters": 491520,
>>>     "check-errors": 0,
>>>     "allocated-clusters": 16164,
>>>     "filename": "/tmp/test.qcow2",
>>>     "format": "qcow2",
>>>     "fragmented-clusters": 1937
>>> }
>> It is not the same, it shows guest clusters, but we need host
>> clusters - including all metadata, dirty bitmaps, snapshots, etc..
> Ah, right. But isn't that exactly the "disk size" (actual-size in JSON)=

> from qemu-img info? Your commit message mentions non-sparse filesystems=

> (which one?), but why wouldn't "disk size" provide this information
> there?
>
> The one case where it doesn't work is if you store a qcow2 image on a
> raw block device (this is something that oVirt does). In that case,
> you can't benefit from sparseness and disk space is used for a cluster
> in the middle even if its refcount is 0. oVirt uses "image-end-offset"
> to get the size of the first of the block device that is actually in us=
e
> by the image.
>
> What is your exact use case? Maybe this helps me understand the exact
> kind of information that you need.
>
> Kevin
Let us assume we have an image like the following:
  [0][1][2][3][4][5][6]
Here [N] represents guest block number N, i.e. there are
7 sequential guest blocks. Let us assume that the guest
issues TRIM and says that block [1] is not needed at all.
The image becomes like
  [0][.][2][3][4][5][6]
If the filesystem with this image is dumb and does not
support holes, we could not determine that we have
not used space inside the disk marked as [.]

The goal of this patch is to know amount of [.] blocks.

Den
