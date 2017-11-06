Received: from eggs.gnu.org ([2001:4830:134:3::10]:49494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBhle-0002wr-IC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBhlc-0007GW-US
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:48:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1eBhlc-0007GA-Ol
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:48:44 -0500
Date: Mon, 6 Nov 2017 14:48:39 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171106134839.lu3rzudfthnfeisa@localhost.localdomain>
References: <20171106132805.19986-1-jfreimann@redhat.com>
	<CAFEAcA_nYzSr5BodQAeHr_knc4XKMwQKNT_rAmJ25RDx3ba01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFEAcA_nYzSr5BodQAeHr_knc4XKMwQKNT_rAmJ25RDx3ba01Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On Mon, Nov 06, 2017 at 01:29:42PM +0000, Peter Maydell wrote:
>On 6 November 2017 at 13:28, Jens Freimann <jfreimann@redhat.com> wrote:
>> This fixes coverity issue CID1005339.
>>
>> Make sure that saddr is not used uninitialized if the
>> mcast parameter is NULL.
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  net/socket.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index e6b471c63d..51eaea67a0 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -332,7 +332,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>                                                  const char *mcast,
>>                                                  Error **errp)
>>  {
>> -    struct sockaddr_in saddr;
>> +    struct sockaddr_in saddr = { 0 };
>
>Do we really need the initialization here? With the two if()
>conditions aligned we should be properly initializing it
>in all the cases we use it, or have I missed one?

We don't need it. I added it not to have the same problem again if
the code changes in the future. I think it shouldn't hurt
because this code is only run once during initialization.
If you think it's not necessary I'm fine with removing it though. 

regards,
Jens 

>thanks
>-- PMM
