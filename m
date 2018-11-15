Received: from eggs.gnu.org ([2001:4830:134:3::10]:54446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNEx2-0006a3-EH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNEx0-00043z-9Y
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:32:44 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNEwy-00041D-3Q
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:32:40 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so17301487otk.8
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 02:32:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <159ef9c8-e0b2-6183-b33c-6925fb6574dc@redhat.com>
References: <20181031005015.5433-1-zhangckid@gmail.com>
	<159ef9c8-e0b2-6183-b33c-6925fb6574dc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 10:32:16 +0000
Message-ID: <CAFEAcA99FxTp6G8+vG-YsjWA5LAye1T3j4_h=5_uM6WbZaW2QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>

On 2 November 2018 at 02:21, Jason Wang <jasowang@redhat.com> wrote:
>
> On 2018/10/31 =E4=B8=8A=E5=8D=888:50, Zhang Chen wrote:
>>
>> The original code just follow the TCP state diagram,
>> but in this case, we can skip the TCPS_TIME_WAIT state to simplify
>> the implementation.
>>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>   net/filter-rewriter.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
>> index bb8f4d93b1..2e26839bc2 100644
>> --- a/net/filter-rewriter.c
>> +++ b/net/filter-rewriter.c
>> @@ -155,12 +155,13 @@ static int handle_primary_tcp_pkt(RewriterState *r=
f,
>>            * Active close step 2.
>>            */
>>           if (conn->tcp_state =3D=3D TCPS_FIN_WAIT_1) {
>> -            conn->tcp_state =3D TCPS_TIME_WAIT;
>>               /*
>>                * For simplify implementation, we needn't wait 2MSL time
>>                * in filter rewriter. Because guest kernel will track the
>>                * TCP status and wait 2MSL time, if client resend the FIN
>>                * packet, guest will apply the last ACK too.
>> +             * So, we skip the TCPS_TIME_WAIT state here and go straigh=
t
>> +             * to TCPS_CLOSED state.
>>                */
>>               conn->tcp_state =3D TCPS_CLOSED;
>>               g_hash_table_remove(rf->connection_track_table, key);
>
>
>
> Applied.

Ping -- this doesn't seem to have made it into master?

thanks
-- PMM
