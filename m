Received: from eggs.gnu.org ([2001:4830:134:3::10]:49033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hrgstephen@gmail.com>) id 1cxF8o-0006Wv-NK
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 11:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hrgstephen@gmail.com>) id 1cxF8n-0006Eo-T4
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 11:52:38 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hrgstephen@gmail.com>)
	id 1cxF8n-0006Ei-OJ
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 11:52:37 -0400
Received: by mail-ua0-x22a.google.com with SMTP id u103so16154380uau.1
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 08:52:35 -0700 (PDT)
MIME-Version: 1.0
From: hrg <hrgstephen@gmail.com>
Date: Sun, 9 Apr 2017 23:52:34 +0800
Message-ID: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [RFC/BUG] xen-mapcache: buggy invalidate map cache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefano.stabellini@eu.citrix.com, anthony.perard@citrix.com, xen-devel@lists.xensource.com, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>, wangxinxin.wang@huawei.com

Hi,

In xen_map_cache_unlocked(), map to guest memory maybe in entry->next
instead of first level entry (if map to rom other than guest memory
comes first), while in xen_invalidate_map_cache(), when VM ballooned
out memory, qemu did not invalidate cache entries in linked
list(entry->next), so when VM balloon back in memory, gfns probably
mapped to different mfns, thus if guest asks device to DMA to these
GPA, qemu may DMA to stale MFNs.

So I think in xen_invalidate_map_cache() linked lists should also be
checked and invalidated.

What=E2=80=99s your opinion? Is this a bug? Is my analyze correct?
