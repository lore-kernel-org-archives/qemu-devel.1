Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.de_backer@nokia.com>) id 1gXmxM-0005SS-T9
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.de_backer@nokia.com>) id 1gXmxJ-0001mn-ID
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:52:40 -0500
From: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>
Date: Fri, 14 Dec 2018 12:52:34 +0000
Message-ID: <VI1PR07MB334480C3525B865AE5052903AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
	<20181213144914.GH5427@linux.fritz.box>
	<db4f1763-e28f-387c-2652-ba71c29e97ff@redhat.com>
	<DB6PR07MB3333BA55F6C06E1DB3388D55AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<CAMRbyyug2e_MK+Nzdzso9RheENVzuTba5nYzjBNZbrXCaB2hrw@mail.gmail.com>
	<VI1PR07MB3344412C5DE71936F9689909AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
	<VI1PR07MB334400B255A91277D3597F79AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
	<20181214122659.GB4341@dhcp-200-186.str.redhat.com>
In-Reply-To: <20181214122659.GB4341@dhcp-200-186.str.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] Request for clarification on qemu-img
 convert behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, "Aamir T, Owais (Nokia -
	IN/Chennai)" <owais.aamir_t@nokia.com>

>Of course, we should also think about the other problem you mentioned, rel=
ated to copying a smaller image to a larger block device. Does this require=
 zeroing the parts after the image or should we leave them alone?
>
>I'd tend to say that since you're passing the whole block device as a targ=
et to 'qemu-img convert', and the whole block device will be visible to a g=
uest run with the same block device configuration, we should indeed zero ou=
t the whole device. But then we would declare the F27 behaviour buggy and t=
his case would stay slow (it would become slightly faster because we avoid =
the double writes, but we wouldn't save the writes to the unused space).

As long as it's outside the region of the source image I think you can leav=
e it alone. Similar to deleting a file on a disk also doesn't zero out the =
sectors that were used to store that file before.

>Or we could just refuse to convert if source and target aren't the same si=
ze. Then you would have to use a raw filter driver to select a part from th=
e target image with the offset/size options. But this would break backwards=
 compatibility, and its use is not very intuitive either.

Going that path would certainly break the way Openstack Ironic project uses=
 qemu-img via the ironic-python-agent to image baremetal servers. And I can=
 imagine there are other cases out there using qemu-img to write out disk i=
mages to blockdevices.

Fred
