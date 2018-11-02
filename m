Received: from eggs.gnu.org ([2001:4830:134:3::10]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gIP66-0003xU-6S
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gIP63-0002PH-2w
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:22:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gIP62-0002Ov-So
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:22:03 -0400
References: <20181031005015.5433-1-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <159ef9c8-e0b2-6183-b33c-6925fb6574dc@redhat.com>
Date: Fri, 2 Nov 2018 10:21:57 +0800
MIME-Version: 1.0
In-Reply-To: <20181031005015.5433-1-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] net/filter-rewriter.c: Fix coverity
 static analysis issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Zhang Chen <chen.zhang@intel.com>


On 2018/10/31 =E4=B8=8A=E5=8D=888:50, Zhang Chen wrote:
> The original code just follow the TCP state diagram,
> but in this case, we can skip the TCPS_TIME_WAIT state to simplify
> the implementation.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   net/filter-rewriter.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index bb8f4d93b1..2e26839bc2 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -155,12 +155,13 @@ static int handle_primary_tcp_pkt(RewriterState *=
rf,
>            * Active close step 2.
>            */
>           if (conn->tcp_state =3D=3D TCPS_FIN_WAIT_1) {
> -            conn->tcp_state =3D TCPS_TIME_WAIT;
>               /*
>                * For simplify implementation, we needn't wait 2MSL time
>                * in filter rewriter. Because guest kernel will track th=
e
>                * TCP status and wait 2MSL time, if client resend the FI=
N
>                * packet, guest will apply the last ACK too.
> +             * So, we skip the TCPS_TIME_WAIT state here and go straig=
ht
> +             * to TCPS_CLOSED state.
>                */
>               conn->tcp_state =3D TCPS_CLOSED;
>               g_hash_table_remove(rf->connection_track_table, key);


Applied.

Thanks
