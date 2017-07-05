Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSmUS-0001tt-NN
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSmUR-0001xr-Va
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:45:20 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <b208d3d3-c71a-2604-d473-ff33d51c91ba@redhat.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
	<eb27d632-fae4-23da-48cc-e0c94b9bc584@redhat.com>
	<CAKmqyKMvOukarSU_KG0CF8pY04Yp7RB1RxBV8pZPhWUm2b-Jcg@mail.gmail.com>
	<b208d3d3-c71a-2604-d473-ff33d51c91ba@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 5 Jul 2017 08:44:44 -0700
Message-ID: <CAKmqyKM=QhHhMz+bR=GAtq9aO5u35GaBpxrZQRxau3NYaK26rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 2/4] util/oslib-win32: Remove invalid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jun 30, 2017 at 3:37 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 29/06/2017 18:37, Alistair Francis wrote:
>>> Hmm, I think it's possible, poll_msgs is true here.
>> poll_msgs?
>>
>> If nhandles is 0 then we have already entered an earlier if statement
>> and set ready to either WAIT_FAILED or WAIT_TIMEOUT in which case we
>> can't enter this part of the if statement.
>
> No, that's not correct.  The code is:
>
>     if (poll_msgs) {
>         /* Wait for either messages or handles
>          * -> Use MsgWaitForMultipleObjectsEx
>          */
>         ready = MsgWaitForMultipleObjectsEx(nhandles, handles, timeout,
>                                             QS_ALLINPUT, MWMO_ALERTABLE);
>
>         if (ready == WAIT_FAILED) {
>             gchar *emsg = g_win32_error_message(GetLastError());
>             g_warning("MsgWaitForMultipleObjectsEx failed: %s", emsg);
>             g_free(emsg);
>         }
>     } else if (nhandles == 0) {
>         /* No handles to wait for, just the timeout */
>         if (timeout == INFINITE) {
>             ready = WAIT_FAILED;
>         } else {
>             SleepEx(timeout, TRUE);
>             ready = WAIT_TIMEOUT;
>         }
>
> You can have poll_msgs == TRUE && nhandles == 0.  This happens for
>
>    GPollFD fds[1] = { .fd = G_WIN32_MSG_HANDLE, .events = G_IO_IN };
>    g_poll(fds, 1, timeout);

Ah. Yeah good point.

Ok, I'll respin the series without this patch then.

Thanks,
Alistair

>
> Thanks,
>
> Paolo
>
