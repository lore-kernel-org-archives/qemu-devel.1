Received: from eggs.gnu.org ([2001:4830:134:3::10]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Bul-00082V-6y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Buh-0002rt-05
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1Bug-0002qw-N0
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:14:22 -0400
References: <1492684955-27154-1-git-send-email-lu.zhipeng@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd4021f8-1f41-e904-1f1e-e965bec2584d@redhat.com>
Date: Thu, 20 Apr 2017 08:14:19 -0500
MIME-Version: 1.0
In-Reply-To: <1492684955-27154-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EbwlKiPw8UPE51cnW6UfGqexmJ6ewagKN"
Subject: Re: [Qemu-devel] [PATCH v2] qga: Add support network interface
 statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: berrange@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EbwlKiPw8UPE51cnW6UfGqexmJ6ewagKN
From: Eric Blake <eblake@redhat.com>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Message-ID: <bd4021f8-1f41-e904-1f1e-e965bec2584d@redhat.com>
Subject: Re: [PATCH v2] qga: Add support network interface statistics in
 guest-network-get-interfaces command
References: <1492684955-27154-1-git-send-email-lu.zhipeng@zte.com.cn>
In-Reply-To: <1492684955-27154-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 05:42 AM, ZhiPeng Lu wrote:
> we can get the  network inetrface statistics inside  a virtual machine =
by

s/inetrface/interface/

lose the double spaces (twice)

> guest-network-get-interfaces command.
> it is very userful for us to monitor and analyze network traff.

s/userful/useful/
s/traff/traffic/

>=20
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> Signed-off-by: DanielP.Berrange <berrange@redhat.com>
> Reviewed-by: EricBlake  <eblake@redhat.com>

Please fix the spacing of Daniel and my names to match the spacing we
typically use (I like to visit 'git log' to learn statistics of patches
I've helped on, and incorrect spellings are easy to miss).

Worse, you added Reviewed-by: attributed to me when I did NOT authorize
it on v1:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03026.html

I pointed out that your v1 was incomplete.  Sometimes, I authorize a
conditional R-b, where I state what trivial action must be taken to fix
the patch without needing me to re-read things - but in the case of
missing documentation, where there is a good chance that it may need
wording improvements, I prefer to omit my R-b and read v2 in its entirety=
=2E

> +++ b/qga/qapi-schema.json
> @@ -635,6 +635,31 @@
>             'prefix': 'int'} }
> =20
>  ##
> +# @GuestNetworkInterfaceStat:
> +#
> +# @rx-bytes: received bytes of interface
> +# @rx-packets: received packets of interface
> +# @rx-errs: received error packets of interface
> +# @rx-drop: received drop packets of interface

s/ of interface//g - it's not adding any useful information.

How can you receive a dropped packet?  Obviously, the statistic is
available, but what is it really representing?  Maybe 'dropped packets
detected on receive side' reads better.

> +#
> +# @tx-bytes: send bytes of interface
> +# @tx-packets: send packets of interface

s/send/transmitted/

> +# @tx-errs: send error packets of interface

It's not how many error packets were sent, but how many errors were
detected while attempting to send, so maybe 'error packets detected on
transmission side'

> +# @tx-drop: send drop packets of interface
and 'dropped packets detected on transmission side'

> +# Since: 2.10
> +##
> +{ 'struct': 'GuestNetworkInterfaceStat',
> +  'data': {'rx-bytes': 'uint64',
> +            'rx-packets': 'uint64',
> +            'rx-errs': 'uint64',
> +            'rx-drop': 'uint64',
> +            'tx-bytes': 'uint64',
> +            'tx-packets': 'uint64',
> +            'tx-errs': 'uint64',
> +            'tx-drop': 'uint64'
> +           } }
> +
> +##
>  # @GuestNetworkInterface:
>  #
>  # @name: The name of interface for which info are being delivered
> @@ -648,7 +673,8 @@
>  { 'struct': 'GuestNetworkInterface',
>    'data': {'name': 'str',
>             '*hardware-address': 'str',
> -           '*ip-addresses': ['GuestIpAddress'] } }
> +           '*ip-addresses': ['GuestIpAddress'],
> +           '*interface-statics': ['GuestNetworkInterfaceStat'] } }

s/interface-statics/statistics/ (the 'interface-' prefix is redundant,
and you typo'd the remaining portion of the name)

Missing documentation, including a (since 2.10) tag.

So you still do not have my R-b; looking forward to v3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EbwlKiPw8UPE51cnW6UfGqexmJ6ewagKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+LQrAAoJEKeha0olJ0Nqt4YH/3wiPpr2uoRu8uz+8Th66WaK
XFUQdCre6VBgnO2ztvHlzW3+s6JyE171A1uZsM/zZM3g0Bu0pA2KeoLxfAia3MTz
sQCVgcnvZZz+qbSKMyBK1mKnbrdFBL8zi9VH+ROyxvNn9hoOPZDELQe4gn+HxcGw
b8uGdKuoCgCbVzaAp23+HheoV08/gvQDBZIvz3RYAAJAx8Mc6lOU9BDc7utAaDfi
EHT65SFfpTnl/zJh4tuRAv2/okr9DFjsRoG5A/3rmBfpYwTQxTNZ5shnEHPs0rdi
+j6XCsOK0R0v+CE3TuPWgaPRYWS0oE3W5Fytf1a2WMBjrrwcwg64YK1uZJu7jrY=
=9DmI
-----END PGP SIGNATURE-----

--EbwlKiPw8UPE51cnW6UfGqexmJ6ewagKN--
