Received: from eggs.gnu.org ([2001:4830:134:3::10]:34983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxtzb-0003UX-Qv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxtzV-00008Q-VA
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:02:07 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:48854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxtzV-00006B-OM
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:02:01 -0400
Received: by mail-wr0-f180.google.com with SMTP id 108so2038663wra.5
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 05:02:00 -0700 (PDT)
References: <20170929111323.6308-1-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
Date: Fri, 29 Sep 2017 14:01:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 29/09/2017 13:13, Michael Fritscher wrote:
> "
> The biggest issue seems to be the *at stuff. I'll
> try to workaround this via getting the directories' path from the file
> descriptor with the /proc (as it is already done in the 9pfs_utils) -
> luckily,the mingw environment emulates the /proc. If this doesn't work
> I've another idea (the file descriptors needs to be "registered" with the
> path (and saved in a sparse vector or map with the fd as key and the path
> as value). The "big" solution would be to write a 9p_local_windows.c from
> scratch, but I would like to avoid it.
> "

Yes, that's pretty much the only way to do it; it's not the easiest
thing because you have to use NT kernel APIs (NtCreateFile) rather than
e.g. CreateFile.  Likewise for NtQueryAttributesFile,
NtQueryDirectoryObject, etc. NtOpenDirectoryObject. :(

Paolo
