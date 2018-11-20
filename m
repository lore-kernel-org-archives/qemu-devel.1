Received: from eggs.gnu.org ([2001:4830:134:3::10]:38145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBqv-0001uA-2N
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBqo-00069t-Sn
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:38:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPBqo-0005b2-HW
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:38:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so1682437wmd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:37:53 -0800 (PST)
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
	<20181120152753.10463-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db9cd0a4-aff8-e5e2-7e8b-004a992e8097@redhat.com>
Date: Tue, 20 Nov 2018 20:37:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181120152753.10463-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? 2/3] migration: fix
 stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 20/11/18 16:27, Marc-André Lureau wrote:
> Adding an assert is enough to silence GCC.
> 
> ~/src/qemu/migration/global_state.c: In function 'global_state_store_running':
> ~/src/qemu/migration/global_state.c:45:5: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
>       strncpy((char *)global_state.runstate,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>              state, sizeof(global_state.runstate));
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> (alternatively, we could hard-code "running")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   migration/global_state.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 8e8ab5c51e..01805c567a 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -42,6 +42,7 @@ int global_state_store(void)
>   void global_state_store_running(void)
>   {
>       const char *state = RunState_str(RUN_STATE_RUNNING);
> +    assert(strlen(state) < sizeof(global_state.runstate));
>       strncpy((char *)global_state.runstate,
>              state, sizeof(global_state.runstate));
>   }
> 
