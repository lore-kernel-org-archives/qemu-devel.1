Received: from eggs.gnu.org ([2001:4830:134:3::10]:58154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esl9g-0000rT-E3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esl9b-0004D3-Cd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:07:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1esl9b-0004Cc-3u
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:07:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2584Seq134236
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 03:07:25 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gh1kws6ef-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 03:07:24 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Mar 2018 08:07:22 -0000
References: <20180304134548.19498-1-nia.alarie@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 09:07:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180304134548.19498-1-nia.alarie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <255a75ec-5603-3438-cdef-a6784eb5464c@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/sclpconsole: Remove dead code - make
 _error functions void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On 03/04/2018 02:45 PM, Nia Alarie wrote:
> These functions always return 0. By changing their return type to
> void, some dead code can be removed.

the event facility part looks ok, but I am asking myself if we should
go a step further.
Do we need the exit callback at all? We can certainly keep it for reasons of symmetry
but it looks like the other event handlers (quiesce and cpu) do not define it at all.
I addition to that, I have a hard time imagine a usecase for such an exit handler.

> 
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---
>  hw/char/sclpconsole-lm.c          | 3 +--
>  hw/char/sclpconsole.c             | 3 +--
>  hw/s390x/event-facility.c         | 6 +-----
[...]>  include/hw/s390x/event-facility.h | 2 +-
>  6 files changed, 8 insertions(+), 14 deletions(-)

> 
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index c500bdaf29..7a02db54b8 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -318,9 +318,8 @@ static int console_init(SCLPEvent *event)
>      return 0;
>  }
> 
> -static int console_exit(SCLPEvent *event)
> +static void console_exit(SCLPEvent *event)
>  {
> -    return 0;
>  }
> 
>  static void console_reset(DeviceState *dev)
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index d0265dfa7a..e2a80dd2dd 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -246,9 +246,8 @@ static void console_reset(DeviceState *dev)
>     scon->notify = false;
>  }
> 
> -static int console_exit(SCLPEvent *event)
> +static void console_exit(SCLPEvent *event)
>  {
> -    return 0;
>  }
> 
>  static Property console_properties[] = {
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 155a69467b..4263d28012 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -436,11 +436,7 @@ static void event_unrealize(DeviceState *qdev, Error **errp)
>      SCLPEvent *event = SCLP_EVENT(qdev);
>      SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
>      if (child->exit) {
> -        int rc = child->exit(event);
> -        if (rc < 0) {
> -            error_setg(errp, "SCLP event exit failed.");
> -            return;
> -        }
> +        child->exit(event);
>      }
>  }
> 
[...]

>  /* Performance improves when virtqueue kick processing is decoupled from the
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index 5119b9b7f0..833f12a5e7 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -174,7 +174,7 @@ typedef struct SCLPEvent {
>  typedef struct SCLPEventClass {
>      DeviceClass parent_class;
>      int (*init)(SCLPEvent *event);
> -    int (*exit)(SCLPEvent *event);
> +    void (*exit)(SCLPEvent *event);
> 
>      /* get SCLP's send mask */
>      unsigned int (*get_send_mask)(void);
> 
