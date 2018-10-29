Received: from eggs.gnu.org ([2001:4830:134:3::10]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH5JI-0004cQ-Ru
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH5JG-00047D-UW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:02:16 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:44797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH5JE-00041R-OH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:02:14 -0400
Received: by mail-ot1-x32a.google.com with SMTP id p23so7075771otf.11
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:02:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539919345-10703-2-git-send-email-jasowang@redhat.com>
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
	<1539919345-10703-2-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 11:01:44 +0000
Message-ID: <CAFEAcA8fcR47WmOqkNYJfp2K=Zgt+vE_O+2ANKj6dJiFtKdBaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL V2 01/26] filter-rewriter: Add TCP state
 machine and fix memory leak in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Zhang Chen <chen.zhang@intel.com>

On 19 October 2018 at 04:22, Jason Wang <jasowang@redhat.com> wrote:
> From: Zhang Chen <zhangckid@gmail.com>
>
> We add almost full TCP state machine in filter-rewriter, except
> TCPS_LISTEN and some simplify in VM active close FIN states.
> The reason for this simplify job is because guest kernel will track
> the TCP status and wait 2MSL time too, if client resend the FIN packet,
> guest will resend the last ACK, so we needn't wait 2MSL time in filter-rewriter.
>
> After a net connection is closed, we didn't clear its related resources
> in connection_track_table, which will lead to memory leak.
>
> Let's track the state of net connection, if it is closed, its related
> resources will be cleared up.

Hi. Coverity (CID 1396477) points out that here:

> +        /*
> +         * Active close step 2.
> +         */
> +        if (conn->tcp_state == TCPS_FIN_WAIT_1) {
> +            conn->tcp_state = TCPS_TIME_WAIT;

...this assignment to conn->tcp_state has no effect, because...

> +            /*
> +             * For simplify implementation, we needn't wait 2MSL time
> +             * in filter rewriter. Because guest kernel will track the
> +             * TCP status and wait 2MSL time, if client resend the FIN
> +             * packet, guest will apply the last ACK too.
> +             */
> +            conn->tcp_state = TCPS_CLOSED;

...we immediately overwrite it with a different value.

> +            g_hash_table_remove(rf->connection_track_table, key);
> +        }
>      }

What was the intention of the code here?

thanks
-- PMM
