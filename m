Received: from eggs.gnu.org ([2001:4830:134:3::10]:57576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRh9T-0003te-OB
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRh9N-0000aP-7a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:23:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRh9N-0000Zo-0V
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:23:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id f140so10802821wmd.2
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:23:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20171218135417.28301-1-berrange@redhat.com>
	<20171218135417.28301-2-berrange@redhat.com>
	<b38ef134-69ac-5b90-adb4-6a38190d2dcf@redhat.com>
Message-ID: <f2953a7c-a107-4b42-527e-05e708f1fffd@redhat.com>
Date: Wed, 20 Dec 2017 17:23:17 +0100
MIME-Version: 1.0
In-Reply-To: <b38ef134-69ac-5b90-adb4-6a38190d2dcf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] chardev: convert the socket server
 to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 19/12/2017 09:48, Paolo Bonzini wrote:
> On 18/12/2017 14:54, Daniel P. Berrange wrote:
>> Instead of creating a QIOChannelSocket directly for the chardev
>> server socket, use a QIONetListener. This provides the ability
>> to listen on multiple sockets at the same time, so enables
>> full support for IPv4/IPv6 dual stack.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  chardev/char-socket.c | 72 +++++++++++++++++++++------------------------------
>>  1 file changed, 29 insertions(+), 43 deletions(-)
> 
> Queued, thanks.

I think this has to be squashed in to avoid use-after-free issues left and right
(visible with test-hmp):

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 2d2252a..630a7f2 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -930,6 +930,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
 
             if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
                 object_unref(OBJECT(s->listener));
+                s->listener = NULL;
                 goto error;
             }
 

Paolo

> 
> As a follow-up, it's probably worth creating two new functions for
> respectively tcp_chr_set_client_ioc_name+tcp_chr_new_client and
> tcp_chr_set_client_ioc_name+qio_channel_socket_connect_async
> (with tcp_chr_set_client_ioc_name inlined).
> 
> Paolo
> 
