Received: from eggs.gnu.org ([2001:4830:134:3::10]:43853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cJkyt-000260-Eb
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cJkys-0001rc-BR
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:47:11 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161201170624.26496-1-lersek@redhat.com>
	<148227487620.73.10055858460424473693@790289a7ca88>
	<20161221152226.GH3808@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70b42a58-381d-7011-7eef-2120af178f91@redhat.com>
Date: Wed, 21 Dec 2016 18:47:01 +0100
MIME-Version: 1.0
In-Reply-To: <20161221152226.GH3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] checkpatch.pl false positive (was Re: [PATCH v4
 0/7] q35: add negotiable broadcast SMI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, famz@redhat.com, mst@redhat.com, somlo@cmu.edu, Markus Armbruster <armbru@redhat.com>, michael@walle.cc, qemu-arm@nongnu.org, kraxel@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, imammedo@redhat.com



On 21/12/2016 16:22, Eduardo Habkost wrote:
> On Tue, Dec 20, 2016 at 03:01:17PM -0800, no-reply@patchew.org wrote:
> [...]
>> Checking PATCH 4/7: hw/i386/pc: introduce 2.9 machine types with 0x20 fw_cfg file slots...
>> ERROR: Macros with multiple statements should be enclosed in a do - while loop
>> #126: FILE: include/hw/compat.h:4:
>> +#define HW_COMPAT_2_8 \
>> +    {\
>> +        .driver   = "fw_cfg_mem",\
>> +        .property = "file_slots",\
>> +        .value    = stringify(0x10),\
>> +    },{\
>> +        .driver   = "fw_cfg_io",\
>> +        .property = "file_slots",\
>> +        .value    = stringify(0x10),\
>> +    },
>>
>> total: 1 errors, 0 warnings, 119 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
> 
> It is a false positive, but how exactly can we fix it? Should it
> become a warning instead of an error?

It should already be treated as an exception:

                        my $exceptions = qr{
                                $Declare|
                                module_param_named|
                                MODULE_PARAM_DESC|
                                DECLARE_PER_CPU|
                                DEFINE_PER_CPU|
                                __typeof__\(|
                                union|
                                struct|
                                \.$Ident\s*=\s*|       # <---- see here
                                ^\"|\"$
                        }x;
                        #print "REST<$rest> dstat<$dstat> ctx<$ctx>\n";
                        if ($rest ne '' && $rest ne ',') {
                                if ($rest !~ /while\s*\(/ &&
                                    $dstat !~ /$exceptions/)
                                {
                                        ERROR("Macros with multiple statements should be enclosed in a do - while loop\n" . "$here\n$ctx\n");
                                }


so I guess the first step is debugging it. :)

Paolo
