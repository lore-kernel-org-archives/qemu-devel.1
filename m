Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMej8-00085Y-Eq
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMej3-0003O5-Ox
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:51:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMej3-0003Co-Ae
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:51:53 -0500
References: <20181113184641.4492-1-peter.maydell@linaro.org>
	<20181113184641.4492-2-peter.maydell@linaro.org>
	<b332dd35-0cec-7687-7b68-118e560964a1@redhat.com>
	<CAFEAcA-Fw2niH-XevrqTacouNcM=+xbT3qAqyyuQi+8oK_Xkig@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcbe49b4-4e16-b21c-ef5b-93cd55ae54c7@redhat.com>
Date: Tue, 13 Nov 2018 13:51:33 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Fw2niH-XevrqTacouNcM=+xbT3qAqyyuQi+8oK_Xkig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] scripts/run-coverity-scan: Script to
 run Coverity Scan build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/13/18 1:21 PM, Peter Maydell wrote:

>>
>> set -e...
>>
>>> +check_upload_permissions() {
>>
>>
>> ...and shell functions do NOT intuitively do what you would think. It's
>> almost always better to use explicit error checking than to rely on set -e
>> as a crutch, because then you don't get surprises.
> 
> I think we had this conversation with last year's version
> of this script too :-)  As you say, the use of functions
> makes it maybe better to use explicit error checking -- but
> is there a standard syntax for that that doesn't make
> basic
>   foo
>   bar
>   baz
> "do these things in order" code look weird and require special care?
> At least with set -e you do get error checking, whereas scripts without
> it tend to just plough on regardless (look at configure, which doesn't
> use set -e but doesn't have explicit checking either).

I've seen both:

foo &&
bar &&
baz

and

foo || fail
bar || fail
baz || fail

for some variation of a 'fail' function.  But yeah, once you start 
having to worry about checking everything yourself (or realizing which 
lines don't need checking), you find out how much of a crutch 'set -e' 
tries to be, and then wonder how it ever worked (for the number of cases 
where 'set -e' does not actually catch failure, and cannot be re-enabled 
in smaller scopes).

>>> +TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo
>>> $(pwd)/coverity_tool/cov-analysis-*/bin)"
>>
>>
>> If $CDPATH is set and $COVERITY_TOOL_BASE does not contain /, this could
>> result in garbage being prepended to TOOLBIN as output from the 'cd'. Also,
>> $PWD is nicer than $(pwd); but are you sure the glob in cov-analysis-* won't
>> select too many files?
> 
> The glob is not great, but it is necessary to make the script
> robust over new versions of the tools, which put the version
> number in the cov-analysis-whatever directory name. If
> we do ever get more than one file then the "test -x" below
> will fail, and we'll be able to investigate and fix up the script.

Yeah, I think you're okay on that front.

> 
> CDPATH sounds like a horrific misfeature designed for breaking
> scripts, so I'm not very interested in trying to work around it.
> We don't seem to worry about this in configure either.
> (I suppose we could just unset it at the start of the script.)

Autoconf 'configure' scripts do just that (unset CDPATH up front).  If 
someone ever complains that it actually broke for them, we'll make the 
fix; until then, I can live with the risk.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
