Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ckqin-0003Tg-UK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ckqil-0007Zd-AH
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:22:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ckqil-0007Yj-4Y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:22:31 -0500
Date: Mon, 6 Mar 2017 12:22:27 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170306112227.6beiv44xh7ngpvdj@eukaryote>
References: <20170303185427.32681-1-jsnow@redhat.com>
	<CAMr-obuiwE_ef6OPSJbBtmZYsaqo_mzU9E6q8zhbrviZ6_=krQ@mail.gmail.com>
	<5303cac4-a8d8-bf89-b525-3b0fb1b19127@redhat.com>
	<CAMr-obsrUqvqbLabYgKgv1J+ztn5XCwto6LowoN=S0ZWuFLZMA@mail.gmail.com>
	<871sua4y3u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sua4y3u.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2] qmp-shell: add persistent command
 history
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 06, 2017 at 09:18:29AM +0100, Markus Armbruster wrote:
> Nir Soffer <nirsof@gmail.com> writes:
> 
> > On Fri, Mar 3, 2017 at 9:29 PM, John Snow <jsnow@redhat.com> wrote:

[...]

> >>>>  class QMPCompleter(list):
> >>>>      def complete(self, text, state):
> >>>> @@ -109,6 +112,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> >>>>          self._pretty = pretty
> >>>>          self._transmode = False
> >>>>          self._actions = list()
> >>>> +        self._histfile = os.path.join(os.path.expanduser('~'), '.qmp_history')
> 
> I selfishly object to this filename, because I'm using it with
> 
>     $ socat UNIX:/work/armbru/images/test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
> 
> Just kidding.  But seriously, shouldn't this be named after the
> *application* (qmp-shell) rather than the protocol (qmp)?

FWIW, that sounds reasonable to me.  It's clearer that way -- the raw
QMP input history, when using via `socat` as above and the 'qmp-shell'
history won't get mixed up.

[...]

> >> The warning will be enough to solicit reports and fixes if necessary.
> >
> > I agree, the current solution is good tradeoff.
> 
> For what it's worth, bash seems to silently ignore a history file it
> can't read.  Tested by running "HISTFILE=xxx bash", then chmod 0 xxx, da
> capo.
> 
> > One thing missing, is a call to readline.set_history_length, without
> > it the history
> > will grow without limit, see:
> > https://docs.python.org/2/library/readline.html#readline.set_history_length
> 
> Should this be addressed for 2.9?

Sounds like a nice-to-have for me.

> >>>> +        atexit.register(self.__save_history)
> >>>> +
> >>>> +    def __save_history(self):
> >>>> +        try:
> >>>> +            readline.write_history_file(self._histfile)
> >>>> +        except Exception as e:
> >>>> +            print "Failed to save history file '%s'; %s" % (self._histfile, e)
> >>>>
> >>>>      def __parse_value(self, val):
> >>>>          try:
> >>>
> >>> But I think this is good enough and useful as is.
> >>>
> >>> Reviewed-by: Nir Soffer <nirsof@gmail.com>
> >>>
> 

-- 
/kashyap
