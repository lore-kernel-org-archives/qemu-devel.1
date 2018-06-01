Received: from eggs.gnu.org ([2001:4830:134:3::10]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOlcj-00012k-Jv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOlci-0008FR-FU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:05:49 -0400
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
	<8ccfcf94-2282-b56b-4b79-41c05551d26d@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <582811be-f110-9045-1fb8-9bf186d6dd7b@redhat.com>
Date: Fri, 1 Jun 2018 10:05:40 -0500
MIME-Version: 1.0
In-Reply-To: <8ccfcf94-2282-b56b-4b79-41c05551d26d@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>, Kevin Wolf <kwolf@redhat.com>

On 06/01/2018 08:31 AM, Ari Sundholm wrote:
>>> +++ b/block/blklogwrites.c
>>> @@ -0,0 +1,441 @@
>>> +/*
>>> + * Write logging blk driver based on blkverify and blkdebug.
>>> + *
>>> + * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
>>> + * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
>>> + * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2=20
>>> or later.
>>> + * See the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qemu/sockets.h" /* for EINPROGRESS on Windows */
>>> +#include "block/block_int.h"
>>> +#include "qapi/qmp/qdict.h"
>>> +#include "qapi/qmp/qstring.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qemu/option.h"
>>> +
>>> +/* Disk format stuff - taken from Linux drivers/md/dm-log-writes.c *=
/
>>
>> Your copyright claims GPLv2+; but drivers/md/dm-log-writes.c states=20
>> only "* This file is released under the GPL." - I guess that means=20
>> you're okay (parts of Linux are GPLv2-only, which we can't copy into a=
=20
>> GPLv2+ file).
>>
>=20
> I consulted legal counsel on this part, and it is our opinion that the=20
> constants and structs taken from the Linux kernel are insignificant and=
=20
> required for compatibility, so it should be OK to license the file as=20
> GPLv2+ in any case. Just to confirm, do you see this differently?

I'm not a lawyer, but I don't see any problem for the code you copied=20
from that particular file (that is, any source file that says just "GPL"=20
can be interpreted as "GPLv1+", which is therefore okay to copy into a=20
"GPLv2+" file).  I was more pointing out that in general, any time you=20
copy code but use a different license, you DO have to perform due=20
diligence to ensure you aren't treading on dangerous ground.  And the=20
fact that you consulted legal counsel is a good thing.  If it were a=20
more controversial claim (copying from a "GPLv2-only" file on the ground=20
that the copied portion is part of an essential interface and therefore=20
not bound by GPLv2-only and therefore okay for inclusion in GPLv2+, then=20
I'd have mentioned the legal counsel's advice as part of the commit=20
message; but in this case I don't think that's necessary.  Also, we DO=20
have files in qemu that are GPLv2-only - we don't like adding more when=20
not necessary, but when copying from a GPLv2-only source, it is=20
certainly a justifiable action (rather than worrying about whether=20
licensing your file as GPLv2+ is violating the intent of the copied=20
portions in your file) - but again, I don't see that as something needed=20
for this patch, given that your source file did not state GPLv2-only.

>> Do we still want to support yet another legacy syntax addition?=C2=A0 =
I'd=20
>> rather just require the user to pass in a valid --blockdev=20
>> specification (which implies that you MUST support a QMP description),=
=20
>> and skip the legacy syntax altogether.
>>
>=20
> I believe this was inherited from blkverify, which was used as a basis.=
=20
> I will have to do some research into how to do this properly for this=20
> kind of a driver which requires multiple filenames. Any pointers would=20
> be appreciated.
>

Look at qapi/block-core.json BlockdevOptionsBlkverify for how to declare=20
the QMP type.  Kevin may also have some hints.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
