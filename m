Received: from eggs.gnu.org ([2001:4830:134:3::10]:56114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZzvD-0000g2-Rx
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZzvA-0002iE-JN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:35:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZzv9-0002hq-WA
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:35:16 -0400
References: <20180702140558.18267-1-esposem@usi.ch>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1605e06-dd05-3ffb-fff3-fbb18bc66a50@redhat.com>
Date: Mon, 2 Jul 2018 16:35:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180702140558.18267-1-esposem@usi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qpci_free_pc: sdhci-test and
 vhost-user-test could free() NULL pointers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <esposem@usi.ch>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 02/07/2018 16:05, Emanuele Giuseppe Esposito wrote:
> @@ -152,6 +152,8 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAlloca=
tor *alloc)
> =20
>  void qpci_free_pc(QPCIBus *bus)
>  {
> +    g_assert(bus);
> +
>      QPCIBusPC *s =3D container_of(bus, QPCIBusPC, bus);
> =20
>      g_free(s);
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 1d825eb010..9b486b93bf 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -209,7 +209,9 @@ static QSDHCI *machine_start(const struct sdhci_t *=
test)
> =20
>  static void machine_stop(QSDHCI *s)
>  {
> -    qpci_free_pc(s->pci.bus);
> +    if (s->pci.bus) {
> +        qpci_free_pc(s->pci.bus);
> +    }

Sorry for chiming in just now.

In general, freeing a NULL pointer is a fine thing to do in C.  In your
code you do

    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
    qpci_set_pc(ret, qts, alloc);
    return &ret->bus;

But now &ret->bus can be inside the pointer.  qpci_free_pc must
therefore check for NULL before doing the container_of.

It is debatable whether this change should go in QEMU before your code,
or together with it.  There are good arguments for both sides:

- the container_of is assuming that QPCIBus is the first field of the
struct, but that's a strange assumption: container_of usually is used to
go from an interior pointer to an outside struct, and passing NULL to it
is usually wrong

- but, the struct _does_ have QPCIBus as the first field, so we can
assume that if bus =3D=3D NULL, s will be NULL too.  And g_free(NULL) is =
okay.

I suggest that you add the "if (!bus) { return; }" in your code, in the
same patch that adds the field before QPCIBusPC.

Thanks,

Paolo
