Received: from eggs.gnu.org ([2001:4830:134:3::10]:45093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDZI-0000oz-P0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDZF-0006Up-I8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:45:36 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDZF-0006Uc-DD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:45:33 -0500
Received: by mail-qt0-x241.google.com with SMTP id h53so18290034qth.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:45:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-27-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d072be8-c709-245d-9f8e-b58f1b519a27@amsat.org>
Date: Tue, 21 Feb 2017 13:45:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-27-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 26/30] tests: allows to run single test
 in usb-hcd-ehci-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 02/21/2017 11:14 AM, Marc-André Lureau wrote:
> pci_init() shouldn't be a test function, but instead called before any
> test. This allows to run a single test with -p /x86_64/ehci/....

good point.

>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/usb-hcd-ehci-test.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
> index 57af8a034e..fba84b4bee 100644
> --- a/tests/usb-hcd-ehci-test.c
> +++ b/tests/usb-hcd-ehci-test.c
> @@ -50,11 +50,8 @@ static void ehci_port_test(struct qhc *hc, int port, uint32_t expect)
>
>  /* tests */
>
> -static void pci_init(void)
> +static void test_init(void)
>  {
> -    if (pcibus) {
> -        return;
> -    }
>      pcibus = qpci_init_pc(NULL);
>      g_assert(pcibus != NULL);
>
> @@ -142,7 +139,7 @@ int main(int argc, char **argv)
>      int ret;
>
>      g_test_init(&argc, &argv, NULL);
> -    qtest_add_func("/ehci/pci/init", pci_init);
> +
>      qtest_add_func("/ehci/pci/uhci-port-1", pci_uhci_port_1);
>      qtest_add_func("/ehci/pci/ehci-port-1", pci_ehci_port_1);
>      qtest_add_func("/ehci/pci/ehci-config", pci_ehci_config);
> @@ -161,6 +158,8 @@ int main(int argc, char **argv)
>                  "-drive if=none,id=usbcdrom,media=cdrom "
>                  "-device usb-tablet,bus=ich9-ehci-1.0,port=1,usb_version=1 "
>                  "-device usb-storage,bus=ich9-ehci-1.0,port=2,drive=usbcdrom ");
> +
> +    test_init();
>      ret = g_test_run();
>
>      qtest_end();
>
