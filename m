Received: from eggs.gnu.org ([2001:4830:134:3::10]:49752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqg6r-0002sr-7P
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqg6n-0007mo-Td
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:20:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqg6n-0007mh-Ng
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:19:57 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e1830d3-4b21-163e-ce8b-be74e3b60b1a@redhat.com>
Date: Tue, 27 Feb 2018 08:19:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/29] Modularize generated QAPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> Our qapi-schema.json is composed of modules connected by include
> directives, but the generated code is monolithic all the same: one
> qapi-types.h with all the types, one qapi-visit.h with all the
> visitors, and so forth.  These monolithic headers get included all
> over the place.  In my "build everything" tree, adding a QAPI type
> recompiles about 4800 out of 5100 objects.
>=20
> We wouldn't write such monolithic headers by hand.  It stands to
> reason that we shouldn't generate them, either.
>=20
> This series' basic idea is to split up generated headers to mirror the
> schema's modular structure: one header per module.  That way, you can
> include just what you need.
>=20
> The compile-time improvements can be massive.  Before this series, any
> QAPI schema change recompiles some 4800 out of 5100 objects in my
> "build everything" tree.  Afterwards, adding a type to
> qapi/migration.json recompiles a bit over 100, and a documentation
> change no longer recompiles anything.
>=20
> Related: Marc-Andr=C3=A9's 'unit' pragma proposal.  That's a different =
way
> to split off parts of the generated code, motivated by the desire to
> use poisoned identifiers such as TARGET_I386.  I noted in my review of
> v3 that I "can either accept it, or come up with a better solution."
> This is my attempt at a better solution.  It's a bit more ambitious,
> and thus more useful (I hope).  The pragma has one theoretical
> advantage, though: you can modularize the generated output in
> different ways than the input.  The patches using don't do that,
> however.
>=20

>   186 files changed, 1556 insertions(+), 1352 deletions(-)

I've posted a staging version of this at:

http://repo.or.cz/qemu/ericb.git qapi

Barring any last-minute comments, or a need to rebase for other branches=20
going in, I'll submit a pull request later today.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
