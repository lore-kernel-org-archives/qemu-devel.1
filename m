Received: from eggs.gnu.org ([2001:4830:134:3::10]:55152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6kR-0000vT-6E
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6kQ-000075-Dg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:04:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180704150229.9948-1-f4bug@amsat.org>
	<20180705102022.GE3309@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7b181c1-7383-c76b-efd4-002f928707ac@amsat.org>
Date: Thu, 5 Jul 2018 13:04:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180705102022.GE3309@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/crypto: Simplify
 block_crypto_co_create_opts_luks to avoid a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On 07/05/2018 07:20 AM, Kevin Wolf wrote:
> Am 04.07.2018 um 17:02 hat Philippe Mathieu-Daudé geschrieben:
>> After 1ec4f4160a1 Coverity reported:
>>
>>   Variable cryptoopts going out of scope leaks the storage it points to.
>>
>> Fixes: Coverity CID 1393782 (Resource leak)
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I already sent a much simpler fix:
> [PATCH] block/crypto: Fix memory leak in create error path

Oh OK I searched a bit but missed it.

> The only thing that is needed is replacing the return with a goto.
> Splitting it in three different error paths is unnecessary because the
> cleanup function handle NULL values just fine.

OK, good to know.

>> I think this check is superfluous but I respected the previous code:
>>
>>      ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
>>      if (ret > 0) {
>>          ret = 0;
>>      }
> 
> It is wrong, too. The old code keep the error code, goto fail skipped
> the ret = 0.

So this is not particularly wrong but as superfluous as the current use :)

ret = 0 is only useful if block_crypto_co_create_generic() returned a
value > 0, which seems unlikely.

Regards,

Phil.
