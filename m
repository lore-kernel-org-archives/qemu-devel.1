Received: from eggs.gnu.org ([2001:4830:134:3::10]:41743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHDU6-0002e6-61
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHDU5-0000oD-8l
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:36:54 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:50214)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHDU5-0000o8-1B
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:36:53 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
Date: Wed, 14 Dec 2016 17:36:51 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>


> On 14 Dec 2016, at 17:05, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>>=20
>> However, this raises another question. Wouter deliberately made the
>> query format freeform so that you could e.g. set a context like:
>>=20
>>    backup:modtime>201612081034
>>=20
>> which might (in theory) return a list of blocks which are newer than
>> the given timestamp. It would clearly be impossible to return all =
such
>> contexts. I wonder if we should carve out an exception here.
>>=20
>>=20
>=20
> Interesting. Even query 'backup:modtime>*' would be a problem, not =
only empty query list.
>=20
> Actually, we do not need to 'list contexts', as it is about =
management, not about data transfer. We only need a way to check, that =
particular query selects all needed contexts and no others. Just to be =
sure that we are know, what we will select by NBD_OPT_SET_META_CONTEXT =
with _same_ query.
>=20
> So, I suggest just to say, that _LIST_ can return error if too much =
contexts are selected. And same should be done for _SET_. And it should =
be documented that this result of query (list or error) should be equal =
for these two commands.

(two CCs that always bounce removed)

Hmmm... Well in the '*' case, it's up to the namespace as to how it =
parses things, so '*' could be prohibited entirely or mean 'return the =
first 20 matching' or similar. So that's less of a problem. And 'set =
all' doesn't exist (unlike 'list all').

I think in the LIST case we should allow the server to omit contexts =
under certain circumstances, and allow SET to return ETOOBIG.

--=20
Alex Bligh
