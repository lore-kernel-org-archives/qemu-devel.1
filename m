Received: from eggs.gnu.org ([2001:4830:134:3::10]:41544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7Aky-0000Nq-R2
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 21:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7Aku-0004L8-OO
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 21:45:20 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:48458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7Aku-0004KD-1T
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 21:45:16 -0400
Received: by mail-pg0-x244.google.com with SMTP id v78so16025297pgb.5
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 18:45:15 -0700 (PDT)
References: <20171024085853.32615-1-aik@ozlabs.ru>
	<20171024162752.GA21671@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ef1eab70-8c55-0d75-e516-16ef6a419d04@ozlabs.ru>
Date: Wed, 25 Oct 2017 12:45:10 +1100
MIME-Version: 1.0
In-Reply-To: <20171024162752.GA21671@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On 25/10/17 03:27, Daniel P. Berrange wrote:
> On Tue, Oct 24, 2017 at 07:58:53PM +1100, Alexey Kardashevskiy wrote:
>> The new git-submodule.sh script writes .git-submodule-status to
>> the source directory every time no matter what. This makes it conditional.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> I compile out of tree on a remote guest system where I mount the
>> source directory as "readonly" and build directory as "rw" and
>> scripts/git-submodule.sh tries writing to the source directory even when
>> I manually update modules on a host machine which is quite annoying.
>>
>> Is this something acceptable? Or I am missing something here?
> 
> How did you update the modules - did you manually run  'git submodule update...'
> or did you use the git-submodule.sh script on your host machine ?


I run scripts/git-submodule.sh. Which is not thrilling either as I rather
expect source tree not to be affected in any way when running "make".


> If you run git-submodule.sh on the host, then it should save the status
> file, and then when you run make on the guest system, it should notice
> that you're already updated and never even invoke 'git-submodule.sh update'


scripts/git-submodule.sh also tries writing to the source directory (I
should probably have fixed that branch too) but this failure is not fatal
for "make" but makes it want to try "update" and then "make" fails.


> I'm not against your proposal below, but I'm curious why you're seeing
> 'git-submodule.sh update' being run by make in the first place.
> 
>>
>> ---
>>  scripts/git-submodule.sh | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>> index d8fbc7e47e..b642994a67 100755
>> --- a/scripts/git-submodule.sh
>> +++ b/scripts/git-submodule.sh
>> @@ -33,6 +33,8 @@ status)
>>      ;;
>>  update)
>>      git submodule update --init $modules 1>/dev/null 2>&1
>> -    git submodule status $modules > "${substat}"
>> +    substat_tmp=$(mktemp)
>> +    git submodule status $modules > "$substat_tmp"
>> +    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
>>      ;;
>>  esac
>> -- 
>> 2.11.0
>>
> 
> Regards,
> Daniel
> 


-- 
Alexey
