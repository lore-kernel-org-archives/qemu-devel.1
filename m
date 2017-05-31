Received: from eggs.gnu.org ([2001:4830:134:3::10]:41516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dG3dI-0004yK-Kx
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dG3dH-0000rt-NN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:25:52 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1dG3dH-0000qn-I0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:25:51 -0400
Received: by mail-io0-x232.google.com with SMTP id p24so15896134ioi.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:25:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3066658b-be68-a69a-6f9e-5c8801bc7091@redhat.com>
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
	<20170531130609.GE16733@stefanha-x1.localdomain>
	<3066658b-be68-a69a-6f9e-5c8801bc7091@redhat.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Wed, 31 May 2017 15:25:30 +0200
Message-ID: <CAJrWOzBr7epXJopDX6Z7rGf5KV-A_E0itGxZ7VLOvOu4MzJzzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, May 31, 2017 at 3:22 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 31/05/2017 15:06, Stefan Hajnoczi wrote:
>>> +
>>> +    while ((next = QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
>>> +        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
>>>          qemu_coroutine_enter(next);
>>>      }
>>>  }
>> What happens if co remains alive and qemu_coroutine_enter(next) causes
>> additional coroutines to add themselves to co->co_queue_wakeup?
>
> Wouldn't that happen only if co is entered again?  Then it will also
> reenter qemu_co_queue_run_restart, which may cause a different wakeup
> order but not any missing wakeups.

Exactly, that what I tried to show with stupid arrows in another mail.
I am not sure that I've succeeded :)

--
Roman
