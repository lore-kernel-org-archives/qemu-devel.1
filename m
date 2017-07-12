Received: from eggs.gnu.org ([2001:4830:134:3::10]:33024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1dVDS1-0003C2-MB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1dVDRy-0001zv-J6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:56:53 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahino@redhat.com>) id 1dVDRy-0001z8-EI
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:56:50 -0400
Received: by mail-qt0-f176.google.com with SMTP id 32so13221829qtv.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 01:56:49 -0700 (PDT)
MIME-Version: 1.0
From: Ala Hino <ahino@redhat.com>
Date: Wed, 12 Jul 2017 11:56:48 +0300
Message-ID: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow Huston <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>

Hi,

We encountered a performance issue when creating a volume for a running VM
and we'd like to share the info with you. The root cause of the issue is in
our code but we found a workaround that relies on qemu-img create
undocumented behavior.

During our tests, we found that in order to create a volume with a backing
file, the baking file has to be valid and accessible. This requires us to
activate the entire chain before creating the volume, and deactivate the
chain after the operation completes. Activating and deactivating the chain
are expensive operations that we prefer to avoid when possible. Below is
the command we use to create volumes:

qemu-img create -f qcow2 -o compat=1.1 -b
8a28cda2-548d-47da-bbba-faa81284f6ba -F raw
/rhev/data-center/e6b272af-84cb-43fc-ae5b-7fe18bc469a2/f47c980a-fd76-44a9-8b78-00d3ab2ffd2f/images/2ff0a3c0-f145-4f83-b668-fc0c39ba191f/d3b69657-892f-499c-9ac3-9c443ead7d9b
1073741824

We also found that when providing the size and the backing format for qemu,
qemu doesn't open the backing chain, and in this case we don't have to
activate/deactivate the entire chain - exactly the behavior we wish to have.
We we'd like to get your confirmation of the above behavior as it isn't
documented, and whether it can be documented.

In addition, we are aware of https://bugzilla.redhat.com/1213786, where a
-u (unsafe) option is planned to be added (see comment #4 in the BZ). Can
you please confirm that once that support is released, it won't break
existing, i.e. code that provides size and backing format assuming that
"unsafe" create is supported?

Thanks,
Ala
