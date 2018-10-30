Received: from eggs.gnu.org ([2001:4830:134:3::10]:57508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gHJMt-00008h-Vr
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 22:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gHJMk-0003so-TH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 22:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gHJMf-0003oN-8Y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 22:02:44 -0400
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
	<1539919345-10703-2-git-send-email-jasowang@redhat.com>
	<CAFEAcA8fcR47WmOqkNYJfp2K=Zgt+vE_O+2ANKj6dJiFtKdBaA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dffc1be5-95ee-9721-9326-77ad1505ab84@redhat.com>
Date: Tue, 30 Oct 2018 10:02:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8fcR47WmOqkNYJfp2K=Zgt+vE_O+2ANKj6dJiFtKdBaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>, Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>


On 2018/10/29 =E4=B8=8B=E5=8D=887:01, Peter Maydell wrote:
> On 19 October 2018 at 04:22, Jason Wang <jasowang@redhat.com> wrote:
>> From: Zhang Chen <zhangckid@gmail.com>
>>
>> We add almost full TCP state machine in filter-rewriter, except
>> TCPS_LISTEN and some simplify in VM active close FIN states.
>> The reason for this simplify job is because guest kernel will track
>> the TCP status and wait 2MSL time too, if client resend the FIN packet=
,
>> guest will resend the last ACK, so we needn't wait 2MSL time in filter=
-rewriter.
>>
>> After a net connection is closed, we didn't clear its related resource=
s
>> in connection_track_table, which will lead to memory leak.
>>
>> Let's track the state of net connection, if it is closed, its related
>> resources will be cleared up.
> Hi. Coverity (CID 1396477) points out that here:
>
>> +        /*
>> +         * Active close step 2.
>> +         */
>> +        if (conn->tcp_state =3D=3D TCPS_FIN_WAIT_1) {
>> +            conn->tcp_state =3D TCPS_TIME_WAIT;
> ...this assignment to conn->tcp_state has no effect, because...
>
>> +            /*
>> +             * For simplify implementation, we needn't wait 2MSL time
>> +             * in filter rewriter. Because guest kernel will track th=
e
>> +             * TCP status and wait 2MSL time, if client resend the FI=
N
>> +             * packet, guest will apply the last ACK too.
>> +             */
>> +            conn->tcp_state =3D TCPS_CLOSED;
> ...we immediately overwrite it with a different value.
>
>> +            g_hash_table_remove(rf->connection_track_table, key);
>> +        }
>>       }
> What was the intention of the code here?
>
> thanks
> -- PMM


Looks not.

Chen, can you please send a patch to fix this?

Thanks
