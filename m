Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu23J-0007lB-5x
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu23F-0002qo-5W
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:22:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40718 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eu23E-0002qR-UC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:22:09 -0500
References: <20180304210608.vn33p6pn7t2nsxv4@var.youpi.perso.aquilenet.fr>
	<20180308185743.3408-1-benjamin.drung@profitbricks.com>
	<88890d90-4dc6-bac3-4591-f29a271181df@redhat.com>
	<1520539656.6051.11.camel@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5af8c70-e6e4-682a-bbd7-6b914b813737@redhat.com>
Date: Thu, 8 Mar 2018 14:21:57 -0600
MIME-Version: 1.0
In-Reply-To: <1520539656.6051.11.camel@profitbricks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v2] slirp: Add classless static routes
 support to DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Drung <benjamin.drung@profitbricks.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@gnu.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org

On 03/08/2018 02:07 PM, Benjamin Drung wrote:
> Am Donnerstag, den 08.03.2018, 13:46 -0600 schrieb Eric Blake:
>> On 03/08/2018 12:57 PM, Benjamin Drung wrote:
>>> This patch will allow the user to specify classless static routes
>>> for
>>> the replies from the built-in DHCP server.
>>>
>>> Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
>>> ---
>>
>> For future patches, when sending a v2, it's best to document here
>> (after
>> the --- separator) what changed from v1.  It's also a good idea to
>> send
>> a fresh thread rather than tying your v2 in-reply-to your v1, so that
>> it
>> doesn't get buried in an old conversation.
>>
>> More submission hints at https://wiki.qemu.org/Contribute/SubmitAPatch
> 
> Thanks. I will do that with the next iteration. Patch v2 addressed all
> remarks from Samuel Thibault.

At this point, since Samuel is the net maintainer, I'll trust his 
judgment on what interface works best; my review is only trying to make 
sure we don't bake in a UI mistake at the last minute (although we can 
adjust things during soft freeze, if needed).


>>>        '*dnssearch': ['String'],
>>>        '*domainname': 'str',
>>> +    '*route':     ['String'],
>>
>> I know we've used ['String'] for previous members, but that's rather
>> heavyweight - it transmits over QMP as:
>>
>> "dnssearch": [ { "str": "foo" }, { "str": "bar" } ]
>>
>> Nicer is ['str'], which transmits as:
>>
>> "route": [ "foo", "bar" ]
>>
>> so the question boils down to whether cross-member consistency is
>> more
>> important than making your additions concise.
> 
> Agreed that ['str'] is nicer. I will update the patch.

The problem is that ['str'] might not work easily for the command line 
glue; I'm more familiar with how QMP exposes things than with the 
command line parsing, and Markus, who is trying to improve command line 
parsing to share more common infrastructure with QMP, might have better 
comments on the topic, except that he's on leave for a few weeks and 
won't respond until after 2.12 is frozen.  Using ['String'] for 
consistency is therefore okay, if you can't get ['str'] working quickly.


>>> @@ -1904,7 +1904,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>        "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-
>>> host=addr]\n"

Here's an example where we made the command line smart.  ipv6-net takes 
TWO pieces of information: addr/int; on the QMP side, we spelled it 
'*ipv6-prefix':'str' + 'ipv6-prefixlen':'int'.  So somewhere in the 
command line parsing code for --net (which I'm less familiar with), 
there is some glue code taking the compact representation and splitting 
it into the more verbose but more direct QMP representation - well, that 
is, if we are converting it into QMP form at all (part of the problem is 
that our command line and runtime control don't always share code, 
although we're trying to get better at that).

>>> +    "         [,route=addr/mask[:gateway]][,tftp=dir][,bootfile=f]
>>> [,hostfwd=rule][,guestfwd=rule]"
>>
>> Urgh - your QMP interface HAS to be further parsed to get to the
>> useful
>> information.  While it's nice to have compact syntax on the command
>> line, it is really worth thinking about making information easier to
>> consume (that is, NO further parsing required once the information is
>> in
>> JSON format).  Would it be any better to send things over the wire
>> as:
>>
>> "route": [ { "addr": "...", "mask": 24, "gateway": "..." } ]
> 
> That's looks good.

Okay, doing that would mean using something like:

{ 'struct': 'RouteEntry', 'data': { 'addr': 'str', '*mask': 'int', 
'*gateway': 'str' } }
...
'route': [ 'RouteEntry' ]

(but reuse, rather than inventing a new type, if one of the existing QMP 
types already resembles what I proposed for RouteEntry)

The command line can still use route=addr/mask:gateway syntax, parse it 
down into components, then compile the QMP array of already-parsed 
structs (rather than making QMP take a direct ['String'] that still 
needs further parsing).  It may take more glue code, but the idea is 
that all the glue code should live on the front end, so that the QMP 
backend should be easy to work with.

> 
>> instead of cramming all the information into a single string?  But
>> based
>> on the way this also maps to the command line, you may not have a
>> choice
>> without a lot more code complexity.
> 
> Can you point me to an example where similar parsing is done?

Hopefully my hint about command-line ipv6-net gets you started (as I 
said, I'm less familiar with the specifics of net code, so much as 
taking the interface point of view here).

>>> +@example
>>> +qemu -net user,route=10.0.2.0/24,route=192.168.0.0/16 [...]
>>> +@end example
>>
>> Can we please spell that '--net', along the lines of
>> https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_docum
>> entation
> 
> I can change it, but then the documentation is inconsistent. There
> are 75 lines with '-net' in qemu-options.hx, but only two lines
> with '--net'.

Yeah, there's that.  But hopefully someone will tackle the bite-sized 
task to get things consistent, and once they do, leaving fewer places 
that still need to be switched is nice.  I can live with either spelling 
until the bite-sized task is tackled, and am not implying you have to 
take on that task yourself, so much as pointing it out so you can choose 
if it is worth the nicer spelling for new content, or leaving it as-is 
to feel more consistent in the short term.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
