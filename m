Received: from eggs.gnu.org ([2001:4830:134:3::10]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz4b4-0001h4-Be
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz4b1-000533-9B
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz4b1-00052N-00
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:33:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7B6983F40
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 17:33:33 +0000 (UTC)
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
	<1505295366-25295-2-git-send-email-peterx@redhat.com>
	<87bmlp1mxl.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ba97cc0-4c1a-a99a-9e9d-ff24cc54db24@redhat.com>
Date: Mon, 2 Oct 2017 12:33:25 -0500
MIME-Version: 1.0
In-Reply-To: <87bmlp1mxl.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hbx2A8JMb8r6s6dxUM2AKVFkMkjRVWtH9"
Subject: Re: [Qemu-devel] [PATCH 1/4] libqtest: add qmp_device_del()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hbx2A8JMb8r6s6dxUM2AKVFkMkjRVWtH9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <0ba97cc0-4c1a-a99a-9e9d-ff24cc54db24@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] libqtest: add qmp_device_del()
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
 <1505295366-25295-2-git-send-email-peterx@redhat.com>
 <87bmlp1mxl.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmlp1mxl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 12:25 PM, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
>> Device deletion is tricky since we'll get both a response and an event=
,
>> while the order of arrival may vary.  Provide a helper to handle this
>> complexity.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  tests/libqtest.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/libqtest.h |  8 ++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index b9a1f18..a34d8c4 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -925,6 +925,54 @@ QDict *qmp(const char *fmt, ...)
>>      return response;
>>  }
>> =20
>> +void qmp_device_del(const char *id)

>> +
>> +    response2 =3D qmp("");
>> +    g_assert(response2);
>> +    g_assert(!qdict_haskey(response2, "error"));
>=20
> qmp_receive() would be cleaner than qmp("").
>=20
>> +
>> +    if (qdict_haskey(response1, "event")) {
>> +        event =3D response1;
>> +    } else if (qdict_haskey(response2, "event")) {
>> +        event =3D response2;
>> +    }
>> +    g_assert(event);
>> +    g_assert(!strcmp(qdict_get_str(event, "event"), "DEVICE_DELETED")=
);
>> +
>> +    QDECREF(response1);
>> +    QDECREF(response2);
>> +}
>> +
>=20
> Uh, this looks similar to existing qtest_qmp_device_del().  Do we need =
both?

In fact, if I'm reading correctly, this is an early version, which was
retitled into commit acd80015 adding qtest_qmp_device_del().

At any rate, when I post my respin of my libqtest cleanups, I have the
qmp("") slated to be fixed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hbx2A8JMb8r6s6dxUM2AKVFkMkjRVWtH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSeGUACgkQp6FrSiUn
Q2pY0wf+IxtU/fXhiBlRTcB+yhF9YP+w+f8+e9wx4fB+NRDc+JgU1bdZ8U7bjgZ8
15Yj8DOBqAjbVSHtTMJKY6tmfAOLnsAwOByVPYaEd0mgBWacfVAiyUt7b9h5MKe+
tWsWTZ9F6iKJSivWaWEEQlVF2qTWO4mea4CFYGv+DYB6bfWLKBJQ00MPbjO1eRb1
EkudMDsMdBz0nil62tWOCsMTt8gN9XekBzn4nMyxS6AvmH5+ECpKc5s5Sjg62Olf
fUQWWDNkwiMoJlJ+OMpXpfpRmhjKJlF0Twwe5Cjo6piVUTLWKQ1pNAtJoQ9VQm11
Z65b4GXsrcgxU5zokZJNIVLY16NXOA==
=8u4t
-----END PGP SIGNATURE-----

--Hbx2A8JMb8r6s6dxUM2AKVFkMkjRVWtH9--
