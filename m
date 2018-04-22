Received: from eggs.gnu.org ([2001:4830:134:3::10]:51581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fABao-0006kC-5H
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 05:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fABal-0005L4-41
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 05:47:34 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:48655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fABak-0005Jn-Sp
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 05:47:31 -0400
Date: Sun, 22 Apr 2018 11:47:28 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180422094728.GB29670@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
	<954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 17, 2018 at 04:18:43PM -0500, Eric Blake wrote:
> Focusing on just the interface:
>
>> +++ b/qapi/misc.json
>> @@ -1185,6 +1185,26 @@
>>  { 'command': 'pmemsave',
>>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>>
>> +##
>> +# @pmemload:
>> +#
>> +# Load a portion of guest physical memory from a file.
>> +#
>> +# @val: the physical address of the guest to start from
>> +#
>> +# @size: the size of memory region to load
>
> Should size be an optional parameter (default read to the end of the file)?
>
>> +#
>> +# @offset: the offset in the file to start from
>
> Should offset be an optional parameter (default start reading from
> offset 0 of the file)?

>From the QAPI point-of-view making both optional seems like a
good idea, however then pmemsave should also mark its "size"
parameter optional for consistency (this is backwards compatible
as existing callers are not affected).

On the monitor API side this is more problematic as the order of
the pmemsave/pmemload parameters make optional parameters
impossible.

Personally I'd keep it as is because it's simple and consistent
with the existing interface (and can be changed in the future
without breaking compatibility).

In case you prefer those parameters to be optional I'll require
some help to implement that: I don't understand how
qapi-schema.json, hmp-commands.hx and hmp.h interact (I've to
admit I just copied that from the original patch and didn't give
it much thought as it worked fine) and would require some
pointers on how to implement optional arguments for
qapi-schema.json.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
