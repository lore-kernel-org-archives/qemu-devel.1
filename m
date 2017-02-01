Received: from eggs.gnu.org ([2001:4830:134:3::10]:56546)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+725923050baa87684dc2+4910+infradead.org+dwmw2@twosheds.srs.infradead.org>)
	id 1cYu8Y-0005Of-0f
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+725923050baa87684dc2+4910+infradead.org+dwmw2@twosheds.srs.infradead.org>)
	id 1cYu8U-0001Iq-2S
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:35:46 -0500
Received: from twosheds.infradead.org ([90.155.92.209]:38324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+725923050baa87684dc2+4910+infradead.org+dwmw2@twosheds.srs.infradead.org>)
	id 1cYu8T-0001GT-NB
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:35:41 -0500
Message-ID: <1485952389.30423.114.camel@infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <488DB976.4030203@redhat.com>
References: <E1KJqa3-00067A-KN@mariner.uk.xensource.com>
	<48874D4A.8000604@codemonkey.ws> <48875849.60200@redhat.com>
	<200807231744.28969.paul@codesourcery.com>	<48897D83.9020707@redhat.com>
	<20080725161714.GA11760@shareable.org>	<488D8837.2090205@redhat.com>
	<20080728115929.GA7484@shareable.org> <488DB976.4030203@redhat.com>
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-hqfJiuAyDOcUgS+QQuei"
Date: Wed, 01 Feb 2017 12:33:09 +0000
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/3] Always use nonblocking mode	for
 qemu_chr_open_fd.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paul Brook <paul@codesourcery.com>


--=-hqfJiuAyDOcUgS+QQuei
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(very old thread)

On Mon, 2008-07-28 at 14:20 +0200, Gerd Hoffmann wrote:
> Jamie Lokier wrote:
> > Is the problem that you want qemu to block when they do that?
> I want ptys behave as close as possible to tcp/unix sockets:
>=20
> =C2=A0* when nobody is connected, then don't send data.=C2=A0=C2=A0Becaus=
e we will
> =C2=A0=C2=A0=C2=A0block forever once the kernel buffer is full, which is =
bad.
> =C2=A0* when someone is connected, we want him get all data.=C2=A0=C2=A0I=
f the reader
> =C2=A0=C2=A0=C2=A0is too slow to keep up, that means we will block now an=
d then, yes.
> =C2=A0=C2=A0=C2=A0Sockets do that too.

Hm? Sockets operate in O_NONBLOCK mode, don't they?=C2=A0

If the other end stops consuming data and the kernel buffers fill up,
the serial driver ignores the resulting -EAGAIN and drops the byte.

And although it's "lossy", it's sane behaviour. It's exactly what you
get on a real RS232 serial line too; if the other end doesn't keep up
with reading the data out of its end, *it* is going to miss bytes.
That's always been the case, and I don't think we need to worry about
it.

We *certainly* shouldn't be blocking the whole guest CPU in the outb
instruction, waiting for ever for the other end to consume data. Which
is what we seem to do at the moment for PTYs.

> Additionally we can also try to drive the ptys / sockets / whatever
> filehandles in non-blocking mode and try propagating the state back to
> the guest so it stops writing.=C2=A0=C2=A0That is a different issue, alth=
ough
> related.=C2=A0=C2=A0IIRC the xen guys have some bits for that ...

We *could*, I suppose, although as noted I'm not sure it's necessary. A
relatively easy answer might be for the serial driver to spot the
-EAGAIN and keep the byte in the transmit FIFO/register, and refrain
from reasserting THRE/TEMT until it's actually managed to send the
byte.

If we really wanted to support fully lossless serial communication, a
better option might be to implement the hardware flow control lines,
and assert CTS only when the (pty/socket/etc.) file descriptor is
writable. Then *if* the guest chooses to use hardware flow control,
that ought to work.

But I still don't think it's necessary. Can't we just make the PTY file
descriptor non-blocking, and then perhaps the monitoring logic added in
commit=C2=A0279e694bc ("Attempt to detect unconnected ptys (Gerd Hoffman)")
can get simpler because it only has to poll an active device for
connectivity in the case where the write() fails.

--=-hqfJiuAyDOcUgS+QQuei
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDzUw
ggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQG
EwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIyMjAw
MDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEw
PwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFIdvFamBia3
uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYep
LkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayT
QLm1CJM6nCpToxDbPSBhPFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9
UjewM2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3Rh
UL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1Qa
MB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/
BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3Nw
LnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb4yJj
nFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ26Y3NOh7
4AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ks
yuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom
+nyK+5swggU9MIIEJaADAgECAhBqC1BYlVMtBFBN4igR/howMA0GCSqGSIb3DQEBCwUAMIGbMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
MRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYxMjIwMDAwMDAwWhcN
MTcxMjIwMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwbTrFaiGdvN2pThnR9q+4eaXB2wQZQNqhter5ZrJ
pPO47e87bZ+f1tmYoh6+rB90G/XN24NErPRfvU4zVzNT9pCtCzSSVnBlZQBpaEYMKhcXo5PGKNsm
An8BoGwNXjlxwbBNRaNO+ky0wNCaMNd1JLxEuvqg9J7rrcpHhWmnpXD5IKa8gv9GyVAJgOpiBOts
p91sShc2kHvWJ5waPEWPCHDH9J+twGGKqKIIU7fdbURLUgUL1wlDSAHf/lgIAVCSj2H2HpoGqHpy
HgOAClX9iRSLNa0Znj8HTaqfOwxXevsz1KkLFY+Ahm426GIEqdfkK2iT6Hhgc7tjNO3f8i5ALQID
AQABo4IB8TCCAe0wHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFILE
dmHLtK6oxmFJZvBhTQhvqrS0MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQA+AfvNhFwtapF5Lzjapgul3zYuEnMfR538Ya1vhP8wuOkcoJeT2gEFXzVO2WUu
eWM0g0/DumnRB53htV/Qq/+vsL0i6a2+iOO7kHi5O7bZkgbdNv0t2lzonDUHi6LTa7NUj+tv+j6y
hW+iNquC3ACP1dIZH8gJmicHblW63qRgp6wxhn315MLBeavi3uiSag2eeKFePiTIwJjN2UYq6kWg
PL5G/Ycf9x/xN1XBTfJiURc0FsXhrA98VMWnt52C5Lo4txhGjzTI+IZg40b3YDs6E7mTYb5KKmbc
QZA9priOFDdj1z5W9BdWhU6I/D0P9y8Z4Tr6+ZscMUVD0RqWy2LeMIIFPTCCBCWgAwIBAgIQagtQ
WJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdy
ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMB4XDTE2MTIyMDAwMDAwMFoXDTE3MTIyMDIzNTk1OVowJDEiMCAGCSqG
SIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMG06xWohnbzdqU4Z0favuHmlwdsEGUDaobXq+WayaTzuO3vO22fn9bZmKIevqwfdBv1zduD
RKz0X71OM1czU/aQrQs0klZwZWUAaWhGDCoXF6OTxijbJgJ/AaBsDV45ccGwTUWjTvpMtMDQmjDX
dSS8RLr6oPSe663KR4Vpp6Vw+SCmvIL/RslQCYDqYgTrbKfdbEoXNpB71iecGjxFjwhwx/SfrcBh
iqiiCFO33W1ES1IFC9cJQ0gB3/5YCAFQko9h9h6aBqh6ch4DgApV/YkUizWtGZ4/B02qnzsMV3r7
M9SpCxWPgIZuNuhiBKnX5Ctok+h4YHO7YzTt3/IuQC0CAwEAAaOCAfEwggHtMB8GA1UdIwQYMBaA
FJJha4LhoqCqT+xn8cKj97SAAMHsMB0GA1UdDgQWBBSCxHZhy7SuqMZhSWbwYU0Ib6q0tDAOBgNV
HQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQED
BQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYB
BQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMF0GA1UdHwRWMFQwUqBQoE6GTGh0
dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMFgGCCsGAQUFBzAChkxodHRwOi8v
Y3J0LmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0R
BBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAPgH7zYRcLWqReS84
2qYLpd82LhJzH0ed/GGtb4T/MLjpHKCXk9oBBV81TtllLnljNINPw7pp0Qed4bVf0Kv/r7C9Iumt
vojju5B4uTu22ZIG3Tb9Ldpc6Jw1B4ui02uzVI/rb/o+soVvojargtwAj9XSGR/ICZonB25Vut6k
YKesMYZ99eTCwXmr4t7okmoNnnihXj4kyMCYzdlGKupFoDy+Rv2HH/cf8TdVwU3yYlEXNBbF4awP
fFTFp7edguS6OLcYRo80yPiGYONG92A7OhO5k2G+Sipm3EGQPaa4jhQ3Y9c+VvQXVoVOiPw9D/cv
GeE6+vmbHDFFQ9Ealsti3jGCA9MwggPPAgEBMIGwMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0Eg
TGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0ECEGoLUFiVUy0EUE3iKBH+GjAwDQYJYIZIAWUDBAIBBQCgggHzMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDIwMTEyMzMwOVowLwYJ
KoZIhvcNAQkEMSIEIHEVlao6KZueggZS7MXn5v9D2aoC4gHdbs/2IS8isYj+MIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQA2HOoI7KjOBcRa6SeSYb3pv876GAodDyvQ9UhcV+U4Vc7c6hMr7YE+PHjK5zTcQgMDuN8rIjxf
5Jl6l9jufLux9seu+uKACDxOvipGu/1VTXHumXIikVIYqVquKrzlyDXwqXNjJmzr+5A+bCz5rt3g
OlNQ5H7M2WFk7XnK4M2WcOUfy4krEPj5fXCavqIckIuCTG1VSQtXu4oRvN9hA4GX39IBXx9Tw29L
2W4u0aS+ILlHbSyO6UAisor1izlR9kjYGlj0flvrUJisxGRBx9GfcuBZqwzf/r66sGlDegNcyK8T
u9Mc6tf8xjgj+ZkHq0eDnUsuEG+eXEmwmRasqfqPAAAAAAAA


--=-hqfJiuAyDOcUgS+QQuei--
