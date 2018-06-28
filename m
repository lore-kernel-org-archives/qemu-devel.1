Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYO3g-0007G4-RC
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYO3f-0003Z5-Ti
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:57:24 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYO3f-0003Y5-P6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:57:23 -0400
Received: by mail-qt0-x242.google.com with SMTP id z6-v6so3608314qti.2
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:57:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530022733-29581-1-git-send-email-esposem@usi.ch>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a91cfbc-5f05-9105-6c52-1e64db860f5b@amsat.org>
Date: Thu, 28 Jun 2018 00:57:18 -0300
MIME-Version: 1.0
In-Reply-To: <1530022733-29581-1-git-send-email-esposem@usi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user-test: added proper TestServer
 *dest initialization in test_migrate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Emanuele Giuseppe Esposito <esposem@usi.ch>, Paolo Bonzini <pbonzini@redhat.com>

Hi Emanuele,

On 06/26/2018 11:18 AM, Emanuele Giuseppe Esposito wrote:
> server->bus in _test_server_free() could be NULL, since TestServer *dest in test_migrate() was not properly initialized like TestServer *s.
> Added init_virtio_dev(dest) and uninit_virtio_dev(dest), so the fields are properly set and when test_server_free(dest); is called, they can be correctly freed.
> 
> The reason for that is init_virtio_dev() calls qpci_init_pc(), that creates a QPCIBusPC * (returned as QPCIBus *), while test_server_free() calls qpci_free_pc(),
> that frees the QPCIBus *. Not calling init_virtio_dev() would leave the QPCIBus * of TestServer unset.

Good finding.

> 
> Problem came out once I modified  pci-pc.c and pci-pc.h, modifying QPCIBusPC by adding another field before QPCIBus bus. Re-running the tests showed vhost-user-test failing.

Please use lines < 80 characters in your commit messages if possible (72
is a good candidate).

> 
> Signed-off-by: Emanuele Giuseppe Esposito <esposem@usi.ch>
> ---
>  tests/vhost-user-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index bbc8091..4d71d5e 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -545,6 +545,7 @@ static gboolean _test_server_free(TestServer *server)
>      g_free(server->mig_path);
>  
>      g_free(server->chr_name);
> +    g_assert(server->bus);

Wouldn't this assert be better placed in qpci_free_pc()?

>      qpci_free_pc(server->bus);
>  
>      g_free(server);
> @@ -706,6 +707,7 @@ static void test_migrate(void)
>      g_free(cmd);
>  
>      init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      size = get_log_size(s);
>      g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
> @@ -761,6 +763,7 @@ static void test_migrate(void)
>      read_guest_mem_server(dest);
>  
>      uninit_virtio_dev(s);
> +    uninit_virtio_dev(dest);
>  
>      g_source_destroy(source);
>      g_source_unref(source);
> 

For the virtio part:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
