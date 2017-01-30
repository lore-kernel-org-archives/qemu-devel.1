Received: from eggs.gnu.org ([2001:4830:134:3::10]:55226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYEua-0006vO-Il
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYEuW-0002Kw-MB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:34:36 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170130161441.30493-1-berto@igalia.com>
References: <20170130161441.30493-1-berto@igalia.com>
Date: Mon, 30 Jan 2017 17:34:29 +0100
Message-ID: <w51vaswzeui.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon 30 Jan 2017 05:14:41 PM CET, Alberto Garcia wrote:

> This patch keeps the index of the last used (i.e. non-zero) entry in
> the refcount table and updates it every time the table changes. The
> refcount-block overlap check then uses that index instead of reading
> the whole table.

Note that while I decided to go for this approach the patch can be made
much simpler by simply stopping at the first empty entry in the refcount
table:

    if ((chk & QCOW2_OL_REFCOUNT_BLOCK) && s->refcount_table) {
        for (i = 0; i < s->refcount_table_size; i++) {
            if (!(s->refcount_table[i] & REFT_OFFSET_MASK)) {
                break;
            }
            if (overlaps_with(s->refcount_table[i] & REFT_OFFSET_MASK,
                s->cluster_size)) {
                return QCOW2_OL_REFCOUNT_BLOCK;
            }
        }
    }

I don't think QEMU produces files where refcount_table[i] == 0 but
refcount_table[i + 1] != 0. Do they even make sense? In any case, my
patch would cover those cases too, but this simplified version wouldn't.

Berto
