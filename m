Received: from eggs.gnu.org ([209.51.188.92]:45129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkXTv-0002m5-Q6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkXTu-0005Po-Ol
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkXTu-0005HL-FI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:58:58 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-6-git-send-email-pbonzini@redhat.com>
	<a4424580-d38d-492f-e996-f58a58485e81@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e96fe73-93e6-e80d-320c-f8316a9dda96@redhat.com>
Date: Fri, 18 Jan 2019 10:58:55 -0600
MIME-Version: 1.0
In-Reply-To: <a4424580-d38d-492f-e996-f58a58485e81@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RgJp5mBB0JNGTff9jpkvAC6na5OrYfvzh"
Subject: Re: [Qemu-devel] [PATCH 5/5] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RgJp5mBB0JNGTff9jpkvAC6na5OrYfvzh
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: lvivier@redhat.com,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Message-ID: <7e96fe73-93e6-e80d-320c-f8316a9dda96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] tests: qgraph API for the qtest driver
 framework
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
 <1547576349-13337-6-git-send-email-pbonzini@redhat.com>
 <a4424580-d38d-492f-e996-f58a58485e81@redhat.com>
In-Reply-To: <a4424580-d38d-492f-e996-f58a58485e81@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 10:39 AM, Thomas Huth wrote:

>> +    QOSGraphEdge *edge =3D g_new0(QOSGraphEdge, 1);
>> +    edge->type =3D type;
>> +    edge->dest =3D g_strdup(dest);
>> +    edge->edge_name =3D g_strdup(opts->edge_name ? : dest);
>=20
> I think I'd write the elvis operator rather as "?:", without the space
> inbetween. (or does our checkpatch script dislike that?)

$ git grep '? :' | wc
     15     121    1059
$ git grep '?:' | wc
    270    1418   19542


>> +bool qos_graph_has_edge(const char *start, const char *dest)
>> +{
>> +    QOSGraphEdgeList *list =3D get_edgelist(start);
>> +    QOSGraphEdge *e =3D search_list_edges(list, dest);
>> +    if (e) {
>> +        return TRUE;
>> +    }
>> +    return FALSE;
>> +}
>=20
> I'm surprised that TRUE and FALSE are also still available with capital=

> letters these days ... The spelling from stdbool.h is lowercase.

All caps versions are from glib's gboolean type (which is NOT a good
substitute for C99 bool), and should be avoided for any use that does
not specifically require gboolean due to type compatibility.

>=20
> Anyway, maybe rather:
>=20
>     return e !=3D NULL;

Or return !!e


>> +void qos_add_test(const char *name, const char *interface,
>> +                  QOSTestFunc test_func, QOSGraphTestOptions *opts)
>> +{
>> +    QOSGraphNode *node;
>> +    char *test_name =3D g_strdup_printf("%s-tests/%s", interface, nam=
e);;
>> +
>> +    if (!opts) {
>> +        opts =3D &(QOSGraphTestOptions) { };
>=20
> Same as above ... is the pointer still valid after the next curly brace=
?

https://stackoverflow.com/questions/47691857/lifetime-of-a-compound-liter=
al

says it is not strict C99, but that

"A far more reasonable rule would indicate that the lifetime of a
compound literal extends until code leaves the function in which it was
used, or the expression creating it is re-executed, whichever happens
first. Since the Standard allows compilers to extend the lifetime of
automatic objects however they see fit, the fact that a compiler does so
should not be considered a bug. On the other hand, a quality compiler
which is deliberately going to be more useful than the Standard requires
should probably explicitly document that fact. Otherwise future
maintainers may declare that any programs that rely upon such sensible
behavior are "defective", and that the compiler can be more "efficient"
if it ceases to support them."

I'm surprised there is not a defect against the C standard to make the
desired semantics explicit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RgJp5mBB0JNGTff9jpkvAC6na5OrYfvzh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCBc8ACgkQp6FrSiUn
Q2p+OAgAg8rm1gnGi5O8i8FfY8v0iPvXKHG6LfARnCAN6hRpWMUYItrFwviaZ6Gm
q74kN/XEw4qNgP6ONtKD/hi+5K3YL8qn4lVkBm+8KDWdSpCsctobhHtBpYWmoRXX
wzLAjyWXobBp+10IdD8H9TJPA48o3NfMsQYW3WbchvDcF9AAgR1qxPts5CXTw31q
aNZaJEYjetlDNdV77bVhQ7opVzvdUGD2oyB2mLXc58YM0sT6zz6N7fo+AZZZeH+D
3D3fWRXNyYqUVVB9bMAWZrzWBYPQys7q0qVZPxyzYpkin6WFxf5cDhY1urIDEO92
5XebPd+rB/VXPcxqchgPDGPlbniJCw==
=F46p
-----END PGP SIGNATURE-----

--RgJp5mBB0JNGTff9jpkvAC6na5OrYfvzh--
