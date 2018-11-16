Received: from eggs.gnu.org ([2001:4830:134:3::10]:41061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gNTlY-0000a0-Sf
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gNTlV-0001B2-O4
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gNTlU-0001Ah-Vm
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:21:49 -0500
References: <20181031005015.5433-1-zhangckid@gmail.com>
	<159ef9c8-e0b2-6183-b33c-6925fb6574dc@redhat.com>
	<CAFEAcA99FxTp6G8+vG-YsjWA5LAye1T3j4_h=5_uM6WbZaW2QA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <409b9337-a9ef-5206-ecde-f3317b62e263@redhat.com>
Date: Fri, 16 Nov 2018 10:21:42 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99FxTp6G8+vG-YsjWA5LAye1T3j4_h=5_uM6WbZaW2QA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zhang Chen <chen.zhang@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>


On 2018/11/15 =E4=B8=8B=E5=8D=886:32, Peter Maydell wrote:
> On 2 November 2018 at 02:21, Jason Wang <jasowang@redhat.com> wrote:
>> On 2018/10/31 =E4=B8=8A=E5=8D=888:50, Zhang Chen wrote:
>>> The original code just follow the TCP state diagram,
>>> but in this case, we can skip the TCPS_TIME_WAIT state to simplify
>>> the implementation.
>>>
>>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>> ---
>>>    net/filter-rewriter.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
>>> index bb8f4d93b1..2e26839bc2 100644
>>> --- a/net/filter-rewriter.c
>>> +++ b/net/filter-rewriter.c
>>> @@ -155,12 +155,13 @@ static int handle_primary_tcp_pkt(RewriterState=
 *rf,
>>>             * Active close step 2.
>>>             */
>>>            if (conn->tcp_state =3D=3D TCPS_FIN_WAIT_1) {
>>> -            conn->tcp_state =3D TCPS_TIME_WAIT;
>>>                /*
>>>                 * For simplify implementation, we needn't wait 2MSL t=
ime
>>>                 * in filter rewriter. Because guest kernel will track=
 the
>>>                 * TCP status and wait 2MSL time, if client resend the=
 FIN
>>>                 * packet, guest will apply the last ACK too.
>>> +             * So, we skip the TCPS_TIME_WAIT state here and go stra=
ight
>>> +             * to TCPS_CLOSED state.
>>>                 */
>>>                conn->tcp_state =3D TCPS_CLOSED;
>>>                g_hash_table_remove(rf->connection_track_table, key);
>>
>>
>> Applied.
> Ping -- this doesn't seem to have made it into master?
>
> thanks
> -- PMM
>

Will send a pull request soon.

Thanks
