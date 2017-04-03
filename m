Received: from eggs.gnu.org ([2001:4830:134:3::10]:44287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cv2WY-0007kN-BP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cv2WV-0002O3-5X
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cv2WU-0002Nr-Sz
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:59:59 -0400
Date: Mon, 3 Apr 2017 14:59:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170403135948.GH32407@stefanha-x1.localdomain>
References: <1491134956-11977-1-git-send-email-nanjekyejoannah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <1491134956-11977-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] scripts/qmp: python3 support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2017 at 03:09:16PM +0300, Joannah Nanjekye wrote:

This patch causes connect() to hang during negotiation.  Please run the
code before sending patches.

>      def __json_read(self, only_event=3DFalse):
>          while True:
> -            data =3D self.__sockfile.readline()
> -            if not data:
> -                return
> -            resp =3D json.loads(data)
> -            if 'event' in resp:
> -                if self._debug:
> -                    print >>sys.stderr, "QMP:<<< %s" % resp
> -                self.__events.append(resp)
> -                if not only_event:
> -                    continue
> -            return resp
> -
> +            data =3D[]
> +            for byte_read in self.__sockfile.read(1):

I think the intention was to read 1 byte at a time but this loop reads
at most 1 byte and no more because read(1) returns 'X' where X is the
byte or '' for end-of-file.

The following code reads more than one byte:

  while True:
      byte_read =3D self.__sockfile.read(1)
      if not byte_read: # end of file
          break
      ...

> +                data.append(byte_read)
> +                joined_data =3D ''.join(str(v) for v in data)

In Python 2 joined_data is a string containing the raw UTF-8 bytes.
That works.

In Python 3 joined_data is a string representation of the individual
bytes in the data array.  For example, if the file contains the '=FC'
character encoded as 0xc3 0xbc in UTF-8, then the result is:

  joined_data =3D "b'\\xc3'b'\\xbc'"

This is unexpected.  Instead we need to decode the array of bytes:

  joined_data =3D b''.join(a).decode('utf-8')

This produces joined_data =3D '=FC' in both Python 2 and Python 3.

The b'' byte literal notation is safe to use in QEMU since it was added
in Python 2.6 (the minimum version for QEMU).

> +                if byte_read =3D=3D '\n':

In Python 3:

  >>> b'\n' =3D=3D '\n'
  False

Since byte_read is a byte (not a str) in Python 3, this line must use
byte literal notation:

  if byte_read =3D=3D b'\n':

(This also works in Python 2 where byte is just str.)

> +                    resp =3D json.loads(json.dumps(joined_data))

Did you mean json.loads(joind_data)?  There is no need to call dumps().

> +                    if 'event' in resp:
> +                        if self._debug:
> +                            print("QMP:<<< %s" % resp, file=3Dsys.stderr=
)=20
> +                        self.__events.append(resp)
> +                        if not only_event:
> +                            continue

The previous line must be discarded before parsing the next one:

  if not only_event:
      data =3D []
      continue

Stefan

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4lVUAAoJEJykq7OBq3PIaiwH/RfO+xKj9spxCXFCO2bADYmX
GqS4ZX2JjlwAUPC68Lor9BqptytEebV92KOvJnhGJ7b4GY9AofwgkLRxcsJ7ba/Q
6JxcwVdzPdqhoUS7cTtTdvGaUoUPidoCYzZ+Tsv5bIj+30jh3ij2xAuQmAciVbPC
NQ5xlsjWexnDEYSBrqGosIDzAdnShv+tJN7O27E9ppzWcW1rzIBelzEGMi47Sbqa
LNVqffL7+4fKcW78yTz67b0Q87Lnlx7VwVd08r9IS9IS9VQ01kEzwv/ztV6dEQGy
Ot3Ss5ztxB7xNr/MlohlEeM/MdXpsDq+WTOfLZne+uXO4kfW+9jMwRLZs7WdmXE=
=NEQI
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
