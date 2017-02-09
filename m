Received: from eggs.gnu.org ([2001:4830:134:3::10]:51796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxc7-0001P5-9F
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxc3-00059D-DO
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:54:55 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxc3-000590-98
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:54:51 -0500
Received: by mail-qt0-x242.google.com with SMTP id n13so2519358qtc.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 14:54:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
	<1485531620-121182-2-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d8c23c86-f545-ed13-4097-1d2bda8e7a73@amsat.org>
Date: Thu, 9 Feb 2017 19:54:46 -0300
MIME-Version: 1.0
In-Reply-To: <1485531620-121182-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/9] memory: make
 memory_listener_unregister idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 01/27/2017 12:40 PM, Paolo Bonzini wrote:
> Make it easy to unregister a MemoryListener without tracking whether it
> had been registered before.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 	v3: new
>
>  memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/memory.c b/memory.c
> index 2bfc37f..8fafd4c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2371,8 +2371,13 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
>
>  void memory_listener_unregister(MemoryListener *listener)
>  {
> +    if (!listener->address_space) {
> +        return;
> +    }
> +
>      QTAILQ_REMOVE(&memory_listeners, listener, link);
>      QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
> +    listener->address_space = NULL;
>  }
>
>  void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>
