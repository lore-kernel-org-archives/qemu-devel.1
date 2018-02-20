Received: from eggs.gnu.org ([2001:4830:134:3::10]:35904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo9W3-0002KI-Tu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo9Vy-0008FM-4B
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:35 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eo9Vx-0008F5-TZ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:30 -0500
Received: by mail-wr0-f193.google.com with SMTP id z12so9162395wrg.4
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 07:07:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1519138892-12836-1-git-send-email-thuth@redhat.com>
	<7b24c0bd-c90c-3835-48b0-c38be4a75983@redhat.com>
Message-ID: <ddb5251b-abb5-b66a-b4a7-dcc6965ba28b@redhat.com>
Date: Tue, 20 Feb 2018 16:07:26 +0100
MIME-Version: 1.0
In-Reply-To: <7b24c0bd-c90c-3835-48b0-c38be4a75983@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Document --rtc-td-hack,
 --localtime and --startdate as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

On 20/02/2018 16:05, Paolo Bonzini wrote:
> On 20/02/2018 16:01, Thomas Huth wrote:
>> These options have been marked in a comment in qemu-options.hx as
>> deprecated in 2009 already (see commit 1ed2fc1fa35fadc0d6), but we
>> never informed the users about these deprecations. Let's catch up
>> on that omission now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  qemu-doc.texi | 13 +++++++++++++
>>  vl.c          |  5 +++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 2f19980..7494042 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -2736,6 +2736,19 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
>>  which is not the recommended way to run QEMU. This backend should not be
>>  used and it will be removed with no replacement.
>>  
>> +@subsection -rtc-td-hack (since 2.12.0)
>> +
>> +The @code{--rtc-td-hack} option has been replaced by
>> +@code{--rtc driftfix=slew}.
>> +
>> +@subsection -localtime (since 2.12.0)
>> +
>> +The @code{--localtime} option has been replaced by @code{--rtc localtime}.
>> +
>> +@subsection -startdate (since 2.12.0)
>> +
>> +The @code{--startdate} option has been replaced by @code{--rtc @var{date}}.
>> +
>>  @section qemu-img command line arguments
>>  
>>  @subsection convert -s (since 2.0.0)
>> diff --git a/vl.c b/vl.c
>> index 0feaca7..84121bf 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3417,6 +3417,8 @@ int main(int argc, char **argv, char **envp)
>>                  break;
>>              case QEMU_OPTION_localtime:
>>                  rtc_utc = 0;
>> +                warn_report("This option is deprecated, "
>> +                            "use '--rtc localtime' instead.");
>>                  break;
>>              case QEMU_OPTION_vga:
>>                  vga_model = optarg;
>> @@ -3672,6 +3674,8 @@ int main(int argc, char **argv, char **envp)
>>                  };
>>  
>>                  qdev_prop_register_global(&slew_lost_ticks);
>> +                warn_report("This option is deprecated, "
>> +                            "use '--rtc driftfix=slew' instead.");
>>                  break;
>>              }
>>              case QEMU_OPTION_acpitable:
>> @@ -3876,6 +3880,7 @@ int main(int argc, char **argv, char **envp)
>>                   */
>>                  break;
>>              case QEMU_OPTION_startdate:
>> +                warn_report("This option is deprecated, use '--rtc' instead.");
>>                  configure_rtc_date_offset(optarg, 1);
>>                  break;
>>              case QEMU_OPTION_rtc:
> 
> Queued, thanks.

... except qemu_rtc_opts has no implied_opt_name, soo it's "-rtc base".
I fixed that up.

Paolo
