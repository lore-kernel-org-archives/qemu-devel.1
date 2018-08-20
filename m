Received: from eggs.gnu.org ([2001:4830:134:3::10]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frkJW-0002cn-Fs
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frk9H-0004Ga-3C
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:23:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frk9G-0004G6-T9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:23:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so14299093wmb.4
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 06:23:10 -0700 (PDT)
References: <20180818025653.21192-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66dfe354-9c2c-8642-a905-03155555fe99@redhat.com>
Date: Mon, 20 Aug 2018 15:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180818025653.21192-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 18/08/2018 04:56, Philippe Mathieu-Daudé wrote:
> Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' checks.
> 
> Replace the strncpy() calls by g_strlcpy() to avoid the following warning:
> 
>   migration/global_state.c: In function 'global_state_store_running':
>   migration/global_state.c:45:5: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
>        strncpy((char *)global_state.runstate,
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>               state, sizeof(global_state.runstate));
>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.html
> 
>  migration/global_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 8e8ab5c51e..d5df502cd5 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -42,7 +42,7 @@ int global_state_store(void)
>  void global_state_store_running(void)
>  {
>      const char *state = RunState_str(RUN_STATE_RUNNING);
> -    strncpy((char *)global_state.runstate,
> +    g_strlcpy((char *)global_state.runstate,
>             state, sizeof(global_state.runstate));
>  }
>  
> 

This is wrong because strlcpy doesn't zero the rest of
global_state.runstate, so you could end up with something like
"running\0ate\0\0..." in global_state.runstate However, the same mistake
is already present in vl.c's runstate_store.

Juan, David, what to do?  strncpy is easy to misuse, but we do have
cases where it's correct and it should tingle the reviewers' spidey
senses...  I wouldn't mind disabling the warning, and using strncpy in
runstate_store, because in practice it's already reported by Coverity
and it can be shut up there.

Thanks,

Paolo
