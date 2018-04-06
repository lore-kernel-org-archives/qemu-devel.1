Received: from eggs.gnu.org ([2001:4830:134:3::10]:49518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f4VzB-0004qv-As
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f4Vz6-0001LO-9M
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:21:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f4Vz5-0001Kb-TO
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B3DD406E8A4
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 18:21:11 +0000 (UTC)
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
	<20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
	<20180308101728.GG4718@redhat.com>
	<f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
	<85d1416c-c442-eaf2-c4a5-3308fd63de3a@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <721a331e-0ba9-58e2-8659-81b725a0ddff@redhat.com>
Date: Fri, 6 Apr 2018 20:21:00 +0200
MIME-Version: 1.0
In-Reply-To: <85d1416c-c442-eaf2-c4a5-3308fd63de3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On 04/06/18 20:10, Eric Blake wrote:
> On 04/06/2018 12:28 PM, Laszlo Ersek wrote:
>
>> I've created an RFC-level "qapi/firmware.json" schema file, based on
>> this discussion. It "builds", and the generated documentation looks
>> acceptable, superficially speaking.
>>
>> Before I post "qapi/firmware.json" for getting comments, I'd like to
>> write JSON text that (a) describes firmware that I use, and (b)
>> conforms to the schema. IOW, I'd like to validate whether the schema
>> is good enough for describing at least such firmware that I know.
>>
>> Is there a tool that generates example JSON objects from a given
>> schema?
>
> I know the QMP shell (scripts/qmp/qmp-shell) lets you enter commands
> with a lot less typing than full JSON, and has a mode where it will
> then echo the full JSON command it constructed from what you typed. To
> be able to quickly validate examples, it may be sufficient to
> temporarily add a new QMP command 'check-firmware':
>
> { 'command': 'check-firmware', 'boxed': true, 'data': 'Firmware' }
>
> assuming 'Firmware' is your top-level 'struct' in the QAPI file, then
> implement a trivial:
>
> qmp_check_firmware(Firmware *obj, Error **errp) {
>     return 0;
> }
>
> so that you can then run QMP shell, and type:
>
> check-firmware arg1=foo arg2=bar ...
>
> which will then generate the corresponding JSON, then either
> successfully do nothing (what you typed validated, AND you have the
> JSON output printed), or print an error (what you typed failed QAPI
> validation, perhaps because it had an unrecognized key, was missing a
> required key, used a wrong type, etc).
>
>> I vaguely recall there used to be one. Otherwise, writing the
>> examples manually looks arduous (and I wouldn't know how to verify
>> them against the schema).
>
> Similarly, if you generate a command the produces a 'Firmware' as the
> return value, then you can populate the generated C struct (since you
> did manage to run the QAPI generator over your new file, you should be
> able to look at the C struct it generated), then output that over QMP
> to show the counterpart JSON that matches the struct as populated.
>

The top level structure is complex / nested, but that doesn't appear to
be an issue. According to the script,

# key=value pairs also support Python or JSON object literal subset notations,
# without spaces. Dictionaries/objects {} are supported as are arrays [].
#
#    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
#
# Both JSON and Python formatting should work, including both styles of
# string literal quotes. Both paradigms of literal values should work,
# including null/true/false for JSON and None/True/False for Python.

This looks awesome, because it should let me provide messy nested input
(which I'll obviously compose in my $EDITOR and then paste it), and then
the QMP shell will both validate and pretty print that. I'm going to try
this.

Thank you, Eric!
Laszlo
