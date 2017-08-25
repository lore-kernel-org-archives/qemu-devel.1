Received: from eggs.gnu.org ([2001:4830:134:3::10]:36074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dl4il-000637-QK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dl4ii-00050O-2G
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:51:43 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dl4ih-0004zS-UD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:51:39 -0400
Received: by mail-qt0-x244.google.com with SMTP id p13so1108112qtp.5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:51:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <alpine.LFD.2.20.1708031718030.16909@wniryva>
	<20170823202728.dsmitbqt7bsezfgq@var.youpi.perso.aquilenet.fr>
	<alpine.LFD.2.20.1708241020570.29123@wniryva>
	<20170824234241.5cfnuic3lmcea6xc@var.youpi.perso.aquilenet.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c56b92bd-f93b-1dfc-47d6-e43eee3922fb@amsat.org>
Date: Thu, 24 Aug 2017 23:51:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170824234241.5cfnuic3lmcea6xc@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] A use-after-free in slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, P J P <ppandit@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, thuth@redhat.com, wjjzhang <wjjzhang@tencent.com>, qemu-devel@nongnu.org

Hi Samuel,

On 08/24/2017 08:42 PM, Samuel Thibault wrote:
> Hello,
> 
> Thanks for the reproducer you sent me offline. Here is a fix which makes
> a lot of sense and fixes the reproducer.  Could you try it with your
> whole testcase?
> 
> Could somebody also review the patch?
> 

Your patch looks correct.

It seems worth to add a soqfree() function for readability:

static inline void soqfree(struct quehead *ifq)
{
     struct mbuf *ifm;

     for (ifm = ifq->ifs_next; ifm != ifq; ifm = ifm->ifs_next) {
         ifm->ifq_so = NULL;
     }
     ifq->ifq_so = NULL;
}

then use:

     if (ifq->ifq_so == so) {
         soqfree(ifq);
     }

same with slirp->if_batchq

Also can you send your patch in the proper format?

Thanks!

Regards,

Phil.

> Samuel
> 
> commit 1a3a763509fad895c907e6978ea034a5c19ee370
> Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Date:   Fri Aug 25 01:35:53 2017 +0200
> 
>      slirp: fix clearing ifq_so from pending packets
>      
>      The if_fastq and if_batchq contain not only packets, but queues of packets
>      for the same socket. When sofree frees a socket, it thus has to clear ifq_so
>      from all the packets from the queues, not only the first.
>      
>      Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> diff --git a/slirp/socket.c b/slirp/socket.c
> index ecec0295a9..4203b80542 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -66,21 +66,29 @@ void
>   sofree(struct socket *so)
>   {
>     Slirp *slirp = so->slirp;
> -  struct mbuf *ifm;
> -
> -  for (ifm = (struct mbuf *) slirp->if_fastq.qh_link;
> -       (struct quehead *) ifm != &slirp->if_fastq;
> -       ifm = ifm->ifq_next) {
> -    if (ifm->ifq_so == so) {
> -      ifm->ifq_so = NULL;
> +  struct mbuf *ifq;
> +
> +  for (ifq = (struct mbuf *) slirp->if_fastq.qh_link;
> +       (struct quehead *) ifq != &slirp->if_fastq;
> +       ifq = ifq->ifq_next) {
> +    if (ifq->ifq_so == so) {
> +      struct mbuf *ifm;
> +      ifq->ifq_so = NULL;
> +      for (ifm = ifq->ifs_next; ifm != ifq; ifm = ifm->ifs_next) {
> +        ifm->ifq_so = NULL;
> +      }
>       }
>     }
>   
> -  for (ifm = (struct mbuf *) slirp->if_batchq.qh_link;
> -       (struct quehead *) ifm != &slirp->if_batchq;
> -       ifm = ifm->ifq_next) {
> -    if (ifm->ifq_so == so) {
> -      ifm->ifq_so = NULL;
> +  for (ifq = (struct mbuf *) slirp->if_batchq.qh_link;
> +       (struct quehead *) ifq != &slirp->if_batchq;
> +       ifq = ifq->ifq_next) {
> +    if (ifq->ifq_so == so) {
> +      struct mbuf *ifm;
> +      ifq->ifq_so = NULL;
> +      for (ifm = ifq->ifs_next; ifm != ifq; ifm = ifm->ifs_next) {
> +        ifm->ifq_so = NULL;
> +      }
>       }
>     }
>   
> 
