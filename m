Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIpH3-000782-UM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIpH0-0006sl-Om
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dIpH0-0006sN-J3
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:42:18 -0400
References: <1493875481-16388-1-git-send-email-thuth@redhat.com>
	<87pofpnljd.fsf@dusky.pond.sub.org> <20170607201410.GA19037@flamenco>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12b801bd-6db6-6645-8179-01455e97d083@redhat.com>
Date: Thu, 8 Jun 2017 06:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170607201410.GA19037@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Fix the -accel parameter and the
 documentation for 'hax'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=ef=bf=bde?= <alex.bennee@linaro.org>

On 07.06.2017 22:14, Emilio G. Cota wrote:
> On Thu, May 04, 2017 at 09:11:50 +0200, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
> (snip)
>>>  STEXI
>>>  @item -accel @var{name}[,prop=@var{value}[,...]]
>>>  @findex -accel
>>>  This is used to enable an accelerator. Depending on the target architecture,
>>> -kvm, xen, or tcg can be available. By default, tcg is used. If there is more
>>> -than one accelerator specified, the next one is used if the previous one fails
>>> -to initialize.
>>> +kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
>>> +more than one accelerator specified, the next one is used if the previous one
>>> +fails to initialize.
>>>  @table @option
>>>  @item thread=single|multi
>>>  Controls number of TCG threads. When the TCG is multi-threaded there will be one
>>> diff --git a/vl.c b/vl.c
>>> index f46e070..0a1b931 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -3725,26 +3725,21 @@ int main(int argc, char **argv, char **envp)
>>>                  qdev_prop_register_global(&kvm_pit_lost_tick_policy);
>>>                  break;
>>>              }
>>> -            case QEMU_OPTION_accel:
>>> +            case QEMU_OPTION_accel: {
>>> +                QemuOpts *accel_opts;
>>
>> Doesn't this shadow the @accel_opts declared in main()'s outermost
>> scope?
> 
> Yes, it does :( Unfortunately Markus' review slipped through the
> cracks and this patch ended up upstream (bde4d9205). It causes
> a regression that breaks qemu_tcg_configure(accel_opts)
> since now accel_opts is always NULL. That is, in `-accel [..],thread=foo'
> foo is ignored.

Ouch, not sure how I managed to miss that ... big sorry, I'll send a
patch for fixing that mess...

 Thomas
