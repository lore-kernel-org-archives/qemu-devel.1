Received: from eggs.gnu.org ([2001:4830:134:3::10]:41112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqbO-000723-8D
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqbL-0003F1-HZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:13:58 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqbL-0003En-CN
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:13:55 -0400
Received: by mail-qt0-x244.google.com with SMTP id c23-v6so6734088qtn.6
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:13:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b0d831f-a2ed-1cc7-e36e-59c66b3547a8@amsat.org>
Date: Tue, 26 Jun 2018 13:13:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] pr-helper: fix --socket-path default
 in help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

On 06/26/2018 12:40 PM, Paolo Bonzini wrote:
> Currently --help shows "(default '(null)')" for the -k/--socket-path
> option.  Fix it by getting the default path in /var/run.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scsi/qemu-pr-helper.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index d0f83176e1..4057cf355c 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -74,8 +74,16 @@ static int uid = -1;
>  static int gid = -1;
>  #endif
>  
> +static void compute_default_paths(void)
> +{
> +    if (!socket_path) {
> +        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
> +    }
> +}
> +
>  static void usage(const char *name)
>  {
> +    compute_default_paths();
>      (printf) (
>  "Usage: %s [OPTIONS] FILE\n"
>  "Persistent Reservation helper program for QEMU\n"
> @@ -845,13 +853,6 @@ static const char *socket_activation_validate_opts(void)
>      return NULL;
>  }
>  
> -static void compute_default_paths(void)
> -{
> -    if (!socket_path) {
> -        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
> -    }
> -}
> -
>  static void termsig_handler(int signum)
>  {
>      atomic_cmpxchg(&state, RUNNING, TERMINATE);
> 
