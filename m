Received: from eggs.gnu.org ([2001:4830:134:3::10]:55754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIbVX-0006YZ-5f
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIbVS-0005y6-Hm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:04:55 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIbVS-0005xn-Cp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:04:50 -0400
Received: by mail-ot0-x241.google.com with SMTP id 15-v6so538474otn.12
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:04:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2b0f5a2-18df-79a2-7caa-45afdc09a172@redhat.com>
References: <20180513085032.27773-1-sw@weilnetz.de>
	<e2b0f5a2-18df-79a2-7caa-45afdc09a172@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 16:04:29 +0100
Message-ID: <CAFEAcA_bbq_ckoUnYs1VvL+389R9KL6HOxxRD2oFMfE05rsg_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Use strings command from cross
 development tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Mike Frysinger <vapier@gentoo.org>, QEMU Developer <qemu-devel@nongnu.org>

On 15 May 2018 at 16:00, Eric Blake <eblake@redhat.com> wrote:
> On 05/13/2018 03:50 AM, Stefan Weil wrote:
>>
>> This fixes cross builds for the (rare) case where cross binutils
>> but no native binutils are installed.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>   configure | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>
>> +strings="${STRINGS-${cross_prefix}strings}"
>>   strip="${STRIP-${cross_prefix}strip}"
>
>
> Hmm - we have pre-existing problems in our configure file.  More on that
> below...
>
>>   windres="${WINDRES-${cross_prefix}windres}"
>>   pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
>> @@ -1956,9 +1957,9 @@ int main(int argc, char *argv[]) {
>>   EOF
>>     if compile_object ; then
>> -    if strings -a $TMPO | grep -q BiGeNdIaN ; then
>> +    if "$strings" -a $TMPO | grep -q BiGeNdIaN ; then
>
>
> I'd much prefer this to be:
>
> if $strings -a $TMPO | grep...
>
> That's because if I have something like this in my environment:
>
> STRINGS='/path/to/strings -a'
>
> it will only work if you allow word splitting on my variable.

Conversely, if I have STRINGS='/path with spaces/to/strings'
in my environment it will only work if you don't do word
splitting on it :-)

thanks
-- PMM
