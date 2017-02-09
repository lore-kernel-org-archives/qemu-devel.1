Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbsKI-0004ZZ-2D
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbsKD-0004ok-Qw
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cbsKD-0004oS-LH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:16:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD041693C8
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 17:16:05 +0000 (UTC)
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
	<3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
	<1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <637397de-f396-c8f4-fb23-b5387d2077d0@redhat.com>
Date: Thu, 9 Feb 2017 18:16:03 +0100
MIME-Version: 1.0
In-Reply-To: <1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/22] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com



On 07/02/2017 21:03, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>>
>>
>> On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
>>> +    if (QTAILQ_IN_USE(chr, next)) {
>>> +        QTAILQ_REMOVE(&chardevs, chr, next);
>>> +    }
>>> +    if (OBJECT(chr)->parent) {
>>> +        object_unparent(OBJECT(chr));
>>> +    } else {
>>> +        object_unref(OBJECT(chr));
>>> +    }
>>
>> What's the case where the "else" is used?  Probably qemu_chr_delete
>> callers should be changed to use object_unparent or object_unref direc=
tly.
>=20
> I thought about that, but calling object_unparent() seems weird,
> since callers aren't much aware of the fact that chardev are added or n=
ot to a
> container (useless distinction imho). I wish the last object_unref()
> would automatically unparent, if the object has a parent. Would that be
> acceptable?

There is a distinction between the two.  The idea is that unparent
removes all persistent references in the object tree, while unref only
removes transient references.  So for example unparent will detach a
device from its bus.  Unparent is basically exploiting the object tree
in order to simplify the handling of reference cycles.

Once you add an object with object_property_add_child, you probably
should remove any transient references you have (such as the one you got
with object_new) and from that point on use object_unparent only.

Paolo
