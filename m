Received: from eggs.gnu.org ([2001:4830:134:3::10]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fej8Y-0006AY-Cq
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fej8U-00012Y-0T
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fej8T-00011J-OG
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:40:33 -0400
References: <1530022733-29581-1-git-send-email-esposem@usi.ch>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9aeb6334-2d17-80e5-dbf0-e86f58229c7b@redhat.com>
Date: Sun, 15 Jul 2018 17:40:23 +0200
MIME-Version: 1.0
In-Reply-To: <1530022733-29581-1-git-send-email-esposem@usi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Emanuele Giuseppe Esposito <esposem@usi.ch>

On 26/06/2018 16:18, Emanuele Giuseppe Esposito wrote:
> server->bus in _test_server_free() could be NULL, since TestServer *dest in test_migrate() was not properly initialized like TestServer *s.
> Added init_virtio_dev(dest) and uninit_virtio_dev(dest), so the fields are properly set and when test_server_free(dest); is called, they can be correctly freed.
> 
> The reason for that is init_virtio_dev() calls qpci_init_pc(), that creates a QPCIBusPC * (returned as QPCIBus *), while test_server_free() calls qpci_free_pc(),
> that frees the QPCIBus *. Not calling init_virtio_dev() would leave the QPCIBus * of TestServer unset.
> 
> Problem came out once I modified  pci-pc.c and pci-pc.h, modifying QPCIBusPC by adding another field before QPCIBus bus. Re-running the tests showed vhost-user-test failing.
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

Queued for 3.0, thanks.

Paolo
