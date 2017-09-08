Received: from eggs.gnu.org ([2001:4830:134:3::10]:51525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqIky-00053O-V0
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqIku-0003ls-3o
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqIkt-0003ke-UU
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<87d171fqzd.fsf@dusky.pond.sub.org>
	<w51mv652zmt.fsf@maestria.local.igalia.com>
Date: Fri, 08 Sep 2017 14:51:29 +0200
In-Reply-To: <w51mv652zmt.fsf@maestria.local.igalia.com> (Alberto Garcia's
	message of "Fri, 08 Sep 2017 13:33:46 +0200")
Message-ID: <8760ct8ib2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org, greg kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>

Alberto Garcia <berto@igalia.com> writes:

> On Fri 08 Sep 2017 12:02:14 PM CEST, Markus Armbruster wrote:
>
>>> +    fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);
>>
>> !arg->has_id implies !arg->id.
>
> Hey Markus,
>
> I have the impression that I've also written code that never uses
> arg->foo when arg->has_foo is false.
>
> Can we then assume that to be NULL/0 in all cases? Also for other data
> types (int, bool, ...)?

QAPI code always passes zero FOOs along with false has_FOOs.  Anything
that doesn't is a bug.  This is particular important when FOO is a
pointer; we don't want to pass around pointers pointing to random junk
in the hope that everybody will obediently check their has_FOO before
dereferencing.

Other code might not always be as well-behaved.  In random context,
checking has_FOO is probably safer.

I still want to eliminate has_FOO for pointer-valued FOO.  So much to
do, so little time!
